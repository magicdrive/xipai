# frozen_string_literal: true

Dir.glob(
  File.expand_path("xipai/**/*.rb", File.dirname(__FILE__)
)).each do |mod_name|
  require_relative "#{mod_name}"
end

require "ostruct"

module Xipai
  class << self

    def lets_do_this!(_mode, _options)
      xipai = Xipai::TableSet.parse_options(_mode, _options)
      result = xipai.apply
      return result
    end

    def replay!(yamldata, _options)
      xipai = Xipai::TableSet.parse_yaml(yamldata)
      result = xipai.apply
      return result
    end

  end
end
