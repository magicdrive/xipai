# frozen_string_literal: true

require File.expand_path("../../xipai", File.dirname(__FILE__))
require "optional"

module Xipai
  module Arrangement
    class Lottery < Xipai::Arrangement::Base

      attributes :mode, :key_words, :hashcode, :without_hashcode, :pretty, :items, :number_of_winners
      require_attributes :mode, :items, :number_of_winners

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, params
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        _result_set = lottery(_shuffled, number_of_winners)

        return Xipai::Result.new(mode, _hashcode, _result_set, params)
      end

      def lottery(_items, _number_of_winners)
        return Some[_number_of_winners].match do |m|
          m.some(->(x){x == 1}) {[_items[0]]}
          m.some(->(x){x > 0}) {|x|_items[0..(x-1)]}
          m.some() {raise "error: number_of_winners"}
        end
      end

    end
  end
end
