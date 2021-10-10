# frozen_string_literal: true

require File.expand_path("../xipai", File.dirname(__FILE__))
require "json"
require "time"

module Xipai
  module Result

    class << self

      def generate(_mode, _hashcode, _set, _options)
        return data_json_string({
          timestamp: Time.now.strftime("%G-W%V-%uT%R%:z"),
          mode: _mode,
            hashcode: _hashcode,
            result: _set,
            options: _options
        })
      end

      def data_json_string(_set, _options)
        return Some[_options[:pretty]].match do |m|
          m.some(->(x){["true" , true,  1].include?(x)}) { JSON.pretty_generate(_set)}
          m.some(->(x){["false", false, 0, nil].include?(x)}) {JSON.generate(_set)}
          m.some {raise "pretty option value is invalid."}
        end
      end

    end
  end
end
