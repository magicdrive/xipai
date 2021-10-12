# frozen_string_literal: true

Dir.glob(
  "arrangement/*.rb", base: File.dirname(__FILE__)
).each do |mode_name|
  require "#{File.dirname(__FILE__)}/#{mode_name}"
end

require "yaml"
require "optional"

module Xipai
  module TableSet

    class << self

      def parse_yaml(yamldata)
        data = hash_deep_symbolize(YAML.load(yamldata))
        return arrange(data[:mode], data)
      end

      def parse_options(mode, options)
        return arrange(mode, hash_deep_symbolize(options))
      end

      def arrange(mode, attrs)
        params = {}
        Some[mode.intern].match do |m|
          m.some(->(x){x == :team}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs[:key_words])
            params[:hashcode]          = attrs[:hashcode]
            params[:without_hashcode]  = attrs[:without_hashcode]
            params[:pretty]            = attrs[:pretty]
            params[:items]             = normalize_csv_array(attrs[:items])
            params[:number_of_members] = attrs[:number_of_members]
            params[:verbose]           = attrs[:verbose]
            params[:replay_output]     = attrs[:replay_output]
          }
          m.some(->(x){x == :lottery}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs[:key_words])
            params[:hashcode]          = attrs[:hashcode]
            params[:without_hashcode]  = attrs[:without_hashcode]
            params[:pretty]            = attrs[:pretty]
            params[:items]             = normalize_csv_array(attrs[:items])
            params[:number_of_winners] = attrs[:number_of_winners]
            params[:verbose]           = attrs[:verbose]
            params[:replay_output]     = attrs[:replay_output]
          }
          m.some(->(x){x == :pair}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs[:key_words])
            params[:hashcode]          = attrs[:hashcode]
            params[:without_hashcode]  = attrs[:without_hashcode]
            params[:key_items]         = normalize_csv_array(attrs[:key_items])
            params[:pretty]            = attrs[:pretty]
            params[:value_items]       = normalize_csv_array(attrs[:value_items])
            params[:verbose]           = attrs[:verbose]
            params[:replay_output]     = attrs[:replay_output]
          }
          m.some(->(x){x == :order}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs[:key_words])
            params[:hashcode]          = attrs[:hashcode]
            params[:without_hashcode]  = attrs[:without_hashcode]
            params[:pretty]            = attrs[:pretty]
            params[:items]             = normalize_csv_array(attrs[:items])
            params[:verbose]           = attrs[:verbose]
            params[:replay_output]     = attrs[:replay_output]
          }
          m.some {raise "Error: mode invalid."}
        end

        table = Object.const_get("Xipai::Arrangement::#{mode.capitalize}").new(hash_deep_symbolize(params))

        return table if table.valid!
      end

      def normalize_csv_array(obj)
        return Some[obj].match do |m|
          m.some(->(x){x.is_a?(String)}) {
            obj == "" ? [] : obj.split(",").map(&:strip)
          }
          m.some(->(x){x.is_a?(Array)})  { obj }
          m.some { "Error: normalize_csv_array invalid value(s)."}
        end
      end

      def hash_deep_symbolize(obj)
        return Some[obj].match do |m|
          m.some(->(x){x.is_a?(Hash)}) {
            obj.inject({}){|memo,(k,v)| memo[k.to_s.intern] = hash_deep_symbolize(v); memo}
          }
          m.some(->(x){x.is_a?(Array)}) {
            obj.inject([]){|memo,v| memo << hash_deep_symbolize(v); memo}
          }
          m.some {obj}
        end
      end

    end
  end
end
