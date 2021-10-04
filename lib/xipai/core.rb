# frozen_string_literal: true
#
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai::Core

  class << self
    def scrumble!(words, hashcode, items)
      hashcode = Xipai::Hashcode.new_or_existing(hashcode)

      seed = words.map {|item|
        item.bytes.reduce(:*)
      }.reduce(:+)

      seed += hashcode.bytes.reduce(:*)

      random = Random.new(seed)
      Xipai::Members.parse(yamlfilepath)

      members = Xipai::Members.get()
      shuffled = members["members"].shuffle!(random: random)
      return {
        hashcode: hashcode,
        order: shuffled
      }
    end
  end

end

