# frozen_string_literal: true

require File.expand_path("../xipai", File.dirname(__FILE__))
require "json"
require "time"
require "optional"

module Xipai
  class Result

    attr_accessor :timestamp, :mode, :hashcode, :result, :options

    def initialize(_mode, _hashcode, _set, _options)
      @timestamp = Time.now
      @mode      = _mode
      @hashcode  = _hashcode
      @result    = _set
      @options   = _options
    end

    def data_json
      data = Some[options].match do |m|
        m.some(->(x){["true" , true,  1, "verbose"].include?(x[:verbose])}) {
          {
            timestamp: timestamp,
            mode:      mode,
            hashcode:  hashcode,
            result:    result,
            options:   options
          }
        }
        m.some(->(x){["false", false, 0, nil, ""].include?(x[:verbose]) }) {
          {
            mode:      mode,
            hashcode:  hashcode,
            result:    result,
          }
        }
        m.some {raise "Error: verbose mode option value is invalid."}
      end


      data = Some[options].match do |m|
        m.some(->(x){["true", true, 1, "without_hashcode"].include?(x[:without_hashcode]) }) {
          data.delete(:hashcode)
          data
        }
        m.some(->(x){["false", false, 0, "", nil].include?(x[:without_hashcode]) }) {
          data
        }
        m.some {raise "Error: without_hashcode option value is invalid."}
      end

      return data_json_string(data)
    end

    def replay_data
      return hash_deep_stringize(options.dup.tap {|me|
        me.delete(:replay_output)
        me[:mode] = me[:mode].to_s
      })
    end

    def replay_output_path
      return nil if [nil, ""].include?(options[:replay_output])
      basename = File.basename(options[:replay_output]).tap {|me|
        break me += ".xipai-replay.yaml" if me !~ /\A(?:.*\.(?:yaml|yml))\z/xo
      }
      return "#{File.dirname(options[:replay_output])}/#{basename}"
    end

    def replay_output?
      return ![nil, ""].include?(options[:replay_output])
    end

    private
    def data_json_string(hash)
      return Some[options[:pretty]].match do |m|
        m.some(->(x){["true" , true,  1, "pretty"].include?(x)}) { JSON.pretty_generate(hash) }
        m.some(->(x){["false", false, 0, nil, ""].include?(x)})  { JSON.generate(hash) }
        m.some { raise "Error: pretty option value is invalid." }
      end
    end

    def hash_deep_stringize(obj)
      return Some[obj].match do |m|
        m.some(->(x){x.is_a?(Hash)}) {
          obj.inject({}){|memo,(k,v)| memo[k.to_s] = hash_deep_stringize(v); memo}
        }
        m.some(->(x){x.is_a?(Array)}) {
          obj.inject([]){|memo,v| memo << hash_deep_stringize(v); memo}
        }
        m.some {obj}
      end
    end

  end
end
