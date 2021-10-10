# frozen_string_literal: true

require "yaml"
require "hashie"

module Xipai
  module TableSet

    class << self

      def parse_yaml(yamlfile)
        data = Hashie::Mash.new(YAML.load_file(yamlfile))
        return Xipai::TableSet.new(data.mode, data)
      end

      def parse_options(mode, options)
        return Xipai::TableSet.new(mode, Hashie::Mash.new(options))
      end

      def initialize(mode, attrs)
        params = {}
        Some[mode.intern].match do |m|
          m.some(->(x){x == :team}) {
            params[:mode]              = attr.mode
            params[:key_words]         = normalize_csv_array(attr.key_words)
            params[:hashcode]          = attr.hashcode
            params[:no_hashcode]       = attr.no_hashcode
            params[:pretty]            = attr.pretty
            params[:items]             = normalize_csv_array(attr.items)
            params[:number_of_members] = attr.number_of_members
          }
          m.some(->(x){x == :lottery}) {
            params[:mode]              = attr.mode
            params[:key_words]         = normalize_csv_array(attr.key_words)
            params[:hashcode]          = attr.hashcode
            params[:no_hashcode]       = attr.no_hashcode
            params[:pretty]            = attr.pretty
            params[:items]             = normalize_csv_array(attr.items)
            params[:number_of_winners] = attr.number_of_winners
          }
          m.some(->(x){x == :pair}) {
            params[:mode]              = attr.mode
            params[:key_words]         = normalize_csv_array(attr.key_words)
            params[:hashcode]          = attr.hashcode
            params[:no_hashcode]       = attr.no_hashcode
            params[:key_items]         = normalize_csv_array(attr.key_items)
            params[:pretty]            = attr.pretty
            params[:value_items]       = normalize_csv_array(attr.value_items)
          }
          m.some(->(x){x == :single}) {
            params[:mode]              = attr.mode
            params[:key_words]         = normalize_csv_array(attr.key_words)
            params[:hashcode]          = attr.hashcode
            params[:no_hashcode]       = attr.no_hashcode
            params[:items]             = normalize_csv_array(attr.items)
          }
          m.some {raise "error: mode invalid."}
        end

        table = "Xipai::Arrangement::#{mode.capitalize}".constantize.new(Hashie::Mash.new(params))

        return table if table.valid!
      end

      def normalize_csv_array(obj)
        return Some[obj].match do |m|
          m.some(->(x){x.is_a?(String)}) { obj.split(",").map(&:strip) }
          m.some(->(x){x.is_a?(Array)})  { obj }
          m.some { "Error: normalize_csv_array invalid value(s)."}
        end
      end
    end
  end
end
