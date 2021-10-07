# frozen_string_literal: true
#
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  module Core

    class << self
      def scrumble!(words, hashcode, items, opt = {})
        seed = words.map {|item|
          item.bytes.reduce(:*)
        }.reduce(:+)

        seed, hashcode = spinkle_hashcode_bytes(seed, opt)

        random = Random.new(seed)

        shuffled = normalize_items(items).shuffle!(random: random)
        return {
          hashcode: hashcode,
          order: shuffled
        }
      end

      def normalize_items(items)
        return items

      end

      def generate_seed()

      end

      def spinkle_hashcode_bytes(seed, opt = {})
        hashcode = Xipai::Hashcode.new_or_existing(hashcode)
        if opt[:no_hashcode] = true
          hashcode = nil
        end
        seed += hashcode.bytes.reduce(:*)


        return seed hashcode
      end


    end

  end
end

