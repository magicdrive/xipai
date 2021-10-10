# frozen_string_literal: true

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

      def initialize(params)
        @params = hash_deep_symbolize(params)
      end

      def hash_deep_symbolize(obj)
        return Some[obj].match do |m|
          m.some(->(x){x.is_a?(Hash)}) {
            obj.inject({}){|memo,(k,v)| memo[k.to_s.intern] =  hash_deep_symbolize(v); memo}
          }
          m.some(->(x){x.is_a?(Array)}) {
            obj.inject([]){|memo,v| memo << hash_deep_symbolize(v); memo}
          }
          m.some {obj}
        end
      end

      def method_missing(method, *args)
        before, result = method_missing_hook(method, *args)
        if before
          return result
        else
          return params[:"#{method}"] if params.has_key?(:"#{method}")
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
