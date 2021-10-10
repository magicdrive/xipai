# frozen_string_literal: true

module Xipai
  module Arrangement
    class Team < Xipai::Arrangement::Base
      attributes :mode, :key_words, :hashcode, :no_hashcode, :pretty, :items, :number_of_members

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        result_set = team(_shuffled, number_of_members)

        return Xipai::Result.generate(mode, _hashcode, result_set)


      end
      def team(_items, _number_of_members)
        return _items.each_slice(_number_of_members)
      end

    end
  end
end
