# frozen_string_literal: true

module Xipai
  module Arrangement
    class Lottery < Xipai::Arrangement::Base

      attributes :mode, :key_words, :hashcode, :no_hashcode, :pretty, :items, :number_of_winners

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        _result_set = lottery(_shuffled, number_of_winners)

        return Xipai::Result.generate(mode, _hashcode, result_set)
      end

      def lottery(_items, _number_of_winners)
        return Some[_number_of_members].match do |m|
          m.some(->(x){x == 1}) {[_items[0]]}
          m.some(->(x){x > 0}) {_items[0..x]}
          m.some() {raise "error: number_of_winners"}
        end
      end

    end
  end
end
