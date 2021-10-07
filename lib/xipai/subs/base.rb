# frozen_string_literal: true

module Xipai
  module Subs
    class Base

      attr_reader :params
      class << self
        def attributes(attrs = %i(a b c))
          define_method(:"__attributes__") {attrs}
          private :"__attributes__"
        end
      end

      def __attributes__
        return %i(a b c)
      end

      def valid!()
        params.keys.each do |key|
          raise "Error: params-#{key} is null value." if [[],{},"",nil].include?(params[key])
        end
        return true
      end

      def initialize(params = {})
        self.params= params
      end

      def method_missing(method, *args)
        before, result = method_missing_hook(method, *args)
        if before
          return params[:"#{method}"] if params.has_key?(:"#{method}")
        else
          result
        end
      end

      def method_missing_hook(method, *args)
        return false, nil
      end

    end
  end
end
