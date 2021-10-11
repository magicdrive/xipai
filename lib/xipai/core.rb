# frozen_string_literal: true
#
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  module Core

    class << self

      def scrumble!(words, hashcode, items, opt = {})
        seed, hashcode = spinkle_hashcode_bytes(generate_seed(words), hashcode, opt)

        random = Random.new(seed)

        shuffled = normalize_items(items).shuffle!(random: random)
        return {
          hashcode: hashcode,
          shuffled: shuffled
        }
      end

      private
      def normalize_items(items)
        return items.map {|item| item.strip}
      end

      def generate_seed(words)
        return seed = words.map {|item|
          item.bytes.reduce(:*)
        }.reduce(:+)
      end

      def spinkle_hashcode_bytes(seed, hashcode, opt = {})
        _hashcode = Xipai::HashcodeGenerator.generate_or_existing(hashcode)
        _hashcode = nil if [true, "true", 1, "no_hashcode"].include?(opt[:no_hashcode])

        seed = seed.to_i if seed.nil?
        seed += _hashcode.bytes.reduce(:*) unless [nil, ""].include?(_hashcode)

        return seed, _hashcode
      end

    end

  end
end

