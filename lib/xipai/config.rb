# frozen_string_literal: true

require "yaml"

module Xipai
  module Config
    attr_accessor :params

    def initialize(attrs = {})
      params = {}
      Some[attrs["mode"].intern].match do |m|
        m.some(->(x){x == :team}) {
          params[:mode]              = attr["mode"]
          params[:key_words]         = attr["key_words"]
          params[:hashcode]          = attr["hashcode"]
          params[:no_hashcode]       = attr["no_hashcode"]
          params[:pretty]            = attr["pretty"]
          params[:items]             = attr["items"]
          params[:number_of_members] = attr["number_of_members"]
        }
        m.some(->(x){x == :lottery}) {
          params[:mode]              = attr["mode"]
          params[:key_words]         = attr["key_words"]
          params[:hashcode]          = attr["hashcode"]
          params[:no_hashcode]       = attr["no_hashcode"]
          params[:pretty]            = attr["pretty"]
          params[:items]             = attr["items"]
          params[:number_of_winners] = attr["number_of_winners"]
        }
        m.some(->(x){x == :pair}) {
          params[:mode]              = attr["mode"]
          params[:key_words]         = attr["key_words"]
          params[:hashcode]          = attr["hashcode"]
          params[:no_hashcode]       = attr["no_hashcode"]
          params[:key_items]         = attr["key_items"]
          params[:pretty]            = attr["pretty"]
          params[:value_items]       = attr["value_items"]
        }
        m.some(->(x){x == :single}) {
          params[:mode]              = attr["mode"]
          params[:key_words]         = attr["key_words"]
          params[:hashcode]          = attr["hashcode"]
          params[:no_hashcode]       = attr["no_hashcode"]
          params[:items]             = attr["items"]
        }
        m.some {raise "error: mode invalid."}
      end

      private
      def valid!()
        params.keys.each do |key|
          raise "Error: params-#{key} is null value." if [[],{},"",nil].include?(params[key])
        end
        return true
      end

      def method_missing(method, *args)
        return params[:"#{method}"] if params.has_key?(:"#{method}")
      end

    end


    class << self

      def parse(yamlfile)
        @members = YAML.load_file(yamlfile)
      end

    end

  end
end

