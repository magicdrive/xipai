# frozen_string_literal: true

require File.expand_path("../../xipai", File.dirname(__FILE__))
require "yaml"
require "optional"

module Xipai
  module Arrangement
    class Base

      attr_reader :params

      class << self
        def attributes(*attrs)
          define_method(:"__attributes__") {attrs}
          private :"__attributes__"
        end

        def require_attributes(*attrs)
          define_method(:"__require_attributes__") {attrs}
          private :"__require_attributes__"
        end
      end

      def __require_attributes__
        #return %i(a b c)
      end

      def __attributes__
        #return %i(a b c)
      end

      def valid!()
        __require_attributes__.each do |key|
          raise "Error: params-#{key} is null value." if [[],{},"",nil].include?(params[key])
        end
        return true
      end

      def initialize(_params)
        @params = _params
      end

      def method_missing(method, *args)
        before, result = method_missing_hook(method, *args)
        if before
          return result
        elsif params.has_key?(:"#{method}")
          return params[:"#{method}"]
        end
        super
      end

      def method_missing_hook(method, *args)
        return false, nil
      end

      def to_replay_data
        return __attributes__.inject({}) do |memo, attribute_name|
          memo[attribute_name] = params[attribute_name]
        end
      end

      def dump_replay_yaml(path)
        raise "Error: replay_yaml path is nil." if path.nil?
        FileUtils.mkdir_p(File.dirname(path))
        YAML.dump(self.to_replay_data, File.open(path, "w"))
      end

    end
  end
end
