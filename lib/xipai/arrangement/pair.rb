# frozen_string_literal: true

require File.expand_path("../../xipai/core", File.dirname(__FILE__))
require File.expand_path("../../xipai/result", File.dirname(__FILE__))
require File.expand_path("../../xipai/arrangement/base", File.dirname(__FILE__))
require "optional"

module Xipai
  module Arrangement
    class Pair < Xipai::Arrangement::Base

      attributes :mode, :key_words, :hashcode, :without_hashcode, :key_items, :pretty, :value_items
      require_attributes :mode, :key_items, :value_items

      def apply
        _hashcode, _shuffled_keys = Xipai::Core.scrumble!(
          key_words, hashcode, key_items, params
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}

        _hashcode, _shuffled_values = Xipai::Core.scrumble!(
          key_words, _hashcode, value_items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}

        result_set = pair(_shuffled_keys, _shuffled_values)

        return Xipai::Result.new(mode, _hashcode, result_set, params)
      end

      def pair(_keys, _values)
        return Hash[Some[{a: _keys.size, b: _values.size}].match { |m|
          m.some(->(x){x[:a] > x[:b]}) {
            result = [].tap {|me|
              _keys.each.with_index do |key, index|
                Some[_values[index]].match do |mat|
                  mat.some(->(x){!x.nil?}) { me.push([key, _values[index]]) }
                  mat.some(->(x){ x.nil?}) { me.push([key, :null]) }
                end
              end
            }
          }
          m.some(->(x){x[:a] < x[:b]}) {
            result = [].tap {|me|
              _values.each.with_index do |value, index|
                Some[_keys[index]].match do |mat|
                  mat.some(->(x){!x.nil?}) { me.push([key[index], value]) }
                  mat.some(->(x){ x.nil?}) { me.push([index.to_s, value]) }
                end
              end
            }
          }
          m.some(->(x){x[:a] == x[:b]}) { |x|
            result = [].tap {|me|
              [*0..(x[:a].to_i-1)].each do |index|
                me.push([_keys[index], _values[index]])
              end
            }
          }
        }]
      end
    end
  end
end
