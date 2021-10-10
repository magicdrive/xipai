# frozen_string_literal: true

module Xipai
  module Arrangement
    class Single < Xipai::Arrangement::Base
      attributes :mode, :key_words, :hashcode, :no_hashcode, :items

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, {}
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        result_set = single(_shuffled)

        return Xipai::Result.generate(mode, _hashcode, result_set)
      end

      def single(_items)
        return _items
      end
    end
  end
end
