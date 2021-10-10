# frozen_string_literal: true

require "yaml"

module Xipai
  module Arrangement
    class Base

      attr_reader :params
      class << self
        def attributes(*attrs)
          define_method(:"__attributes__") {attrs}
          private :"__attributes__"
        end
      end

      def __attributes__
        #return %i(a b c)
        #return %i()
      end

      def valid!()
        __attributes__.each do |key|
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

      def to_replay_data
        _data = { }
        _params = params
        __attributes__.each do |attribute_name|
          data[attribute_name] = params[attribute_name]
        end
        return _data
      end


      def dump_replay_yaml(path)
        raise "error: replay_yaml path is nil." if path.nil?
        FileUtils.mkdir_p(File.dirname(path))
        YAML.dump(self.to_replay_data, File.open(path, "w"))
      end
    end
  end
end
