# frozen_string_literal: true

require File.expand_path("../../xipai/core", File.dirname(__FILE__))
require File.expand_path("../../xipai/result", File.dirname(__FILE__))
require File.expand_path("../../xipai/arrangement/base", File.dirname(__FILE__))

module Xipai
  module Arrangement
    class Order < Xipai::Arrangement::Base
      attributes :mode, :key_words, :hashcode, :without_hashcode, :items
      require_attributes :mode, :items

      def apply
        _hashcode, _shuffled = Xipai::Core.scrumble!(
          key_words, hashcode, items, params
        ).tap {|me| break *[me[:hashcode], me[:shuffled]]}
        result_set = single(_shuffled)

        return Xipai::Result.new(mode, _hashcode, result_set, params)
      end

      def single(_items)
        return _items
      end
    end
  end
end
