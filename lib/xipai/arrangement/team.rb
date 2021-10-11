# frozen_string_literal: true

require File.expand_path("../../xipai", File.dirname(__FILE__))

module Xipai
  module Arrangement
    class Team < Xipai::Arrangement::Base
      attributes :mode, :key_words, :hashcode, :without_hashcode, :pretty, :items, :number_of_members
      require_attributes :mode, :items, :number_of_members

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, params
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        result_set = team(_shuffled, number_of_members)

        return Xipai::Result.new(mode, _hashcode, result_set, params)
      end

      def team(_items, _number_of_members)
        return _items.each_slice(_number_of_members).to_a
      end

    end
  end
end
