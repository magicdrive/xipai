# frozen_string_literal: true

require "optional"

module Xipai
  module Arrangement
    class Pair < Xipai::Arrangement::Base

      attributes :mode, :key_words, :hashcode, :no_hashcode, :key_items, :pretty, :value_items

      def apply
        _hashcode, _shuffled_keys = Xipai::Core.scrumble!(
          key_words, hashcode, items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}

        _hashcode, _shuffled_values = Xipai::Core.scrumble!(
          key_words, _hashcode, items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}

        result_set = pair(shuffled_keys, shuffled_values)

        return Xipai::Result.generate(mode, _hashcode, result_set)
      end

      def pair(_keys, _values)
        return Hash[Some[{a:_keys.size, b: _values.size}].match { |m|
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
            [*0..x[:a].to_i].map do |index|
              result.push([_keys[index], _values[index]])
            end
          }
        }]
      end
    end
  end
end
