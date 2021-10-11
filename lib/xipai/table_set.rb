# frozen_string_literal: true

require File.expand_path("../xipai", File.dirname(__FILE__))
require "yaml"
require "optional"
require "hashie"

module Xipai
  module TableSet

    class << self

      def parse_yaml(yamldata)
        data = Hashie::Mash.new(YAML.load(yamldata))
        return arrange(data.mode, data)
      end

      def parse_options(mode, options)
        return arrange(mode, Hashie::Mash.new(options))
      end

      def arrange(mode, attrs)
        params = {}
        Some[mode.intern].match do |m|
          m.some(->(x){x == :team}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs.key_words)
            params[:hashcode]          = attrs.hashcode
            params[:no_hashcode]       = attrs.no_hashcode
            params[:pretty]            = attrs.pretty
            params[:items]             = normalize_csv_array(attrs.items)
            params[:number_of_members] = attrs.number_of_members
            params[:verbose]           = attrs.verbose
            params[:replay_output]     = attrs.replay_output
          }
          m.some(->(x){x == :lottery}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs.key_words)
            params[:hashcode]          = attrs.hashcode
            params[:no_hashcode]       = attrs.no_hashcode
            params[:pretty]            = attrs.pretty
            params[:items]             = normalize_csv_array(attrs.items)
            params[:number_of_winners] = attrs.number_of_winners
            params[:verbose]           = attrs.verbose
            params[:replay_output]     = attrs.replay_output
          }
          m.some(->(x){x == :pair}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs.key_words)
            params[:hashcode]          = attrs.hashcode
            params[:no_hashcode]       = attrs.no_hashcode
            params[:key_items]         = normalize_csv_array(attrs.key_items)
            params[:pretty]            = attrs.pretty
            params[:value_items]       = normalize_csv_array(attrs.value_items)
            params[:verbose]           = attrs.verbose
            params[:replay_output]     = attrs.replay_output
          }
          m.some(->(x){x == :single}) {
            params[:mode]              = mode.intern
            params[:key_words]         = normalize_csv_array(attrs.key_words)
            params[:hashcode]          = attrs.hashcode
            params[:no_hashcode]       = attrs.no_hashcode
            params[:pretty]            = attrs.pretty
            params[:items]             = normalize_csv_array(attrs.items)
            params[:verbose]           = attrs.verbose
            params[:replay_output]     = attrs.replay_output
          }
          m.some {raise "error: mode invalid."}
        end

        table = Object.const_get("Xipai::Arrangement::#{mode.capitalize}").new(Hashie::Mash.new(params))

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

    end
  end
end
