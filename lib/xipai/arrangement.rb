# frozen_string_literal: true

module Xipai
  class Arrangement
    class << self

      def single(items)
        return items
      end

      def pair(keys, values)
        return Hash[Some[{a:keys.size, b: values.size}].match { |m|
          m.some(->(x){x[:a] > x[:b]}) {
            result = [].tap {|me|
              keys.each.with_index do |key, index|
                Some[values[index]].match do |mat|
                  mat.some(->(x){!x.nil?}) { me.push([key, values[index]]) }
                  mat.some(->(x){ x.nil?}) { me.push([key, :null]) }
                end
              end
            }
          }
          m.some(->(x){x[:a] < x[:b]}) {
            result = [].tap {|me|
              values.each.with_index do |value, index|
                Some[keys[index]].match do |mat|
                  mat.some(->(x){!x.nil?}) { me.push([key[index], value]) }
                  mat.some(->(x){ x.nil?}) { me.push([index.to_s, value]) }
                end
              end
            }
          }
          m.some(->(x){x[:a] == x[:b]}) { |x|
            [*0..x[:a].to_i].map do |index|
              result.push([keys[index], values[index]])
            end
          }
        }]
      end

      def team(items, number_of_members)
        return items.each_slice(number_of_members)
      end

      def lottery(items, number_of_winners)
        return Some[number_of_members].match do |m|
          m.some(->(x){x == 1}) {[items[0]]}
          m.some(->(x){x > 0}) {items[0..x]}
          m.some() {raise "error: number_of_winners"}
        end
      end

    end
  end

end
