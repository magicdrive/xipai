# frozen_string_literal: true

require "yaml"
module Xipai::Members
  class << self

    def parse(yamlfile)
      @members = YAML.load_file(yamlfile)
    end

    def get
      return @members
    end


    def parse(yamlfile)
      @members = YAML.load_file(yamlfile)
    end

    def get
      return @members
    end

  end
end
