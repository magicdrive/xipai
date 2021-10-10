# frozen_string_literal: true
#
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  module Core

    class << self

      def start!(_mode, _options)
        xipai = Xipai::TableSet.parse_options(_mode, _options)
        result = xipai.apply

        puts result
        xipai.dump_replay_yaml(_options[:replay_output]) unless _options[:replay_output].nil?
      end


      def scrumble!(words, hashcode, items, opt = {})
        seed, hashcode = spinkle_hashcode_bytes(generate_seed(words), hashcode, opt)

        random = Random.new(seed)

        shuffled = normalize_items(items).shuffle!(random: random)
        return {
          hashcode: hashcode,
          shuffled: shuffled
        }
      end

      def replay!(yamldata, _options)
        xipai = Xipai::TableSet.parse_yaml(options[:yaml])
        result = xipai.apply

        puts result
        xipai.dump_replay_yaml(_options[:replay_output]) unless _options[:replay_output].nil?
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
        if [true, "true", 1, "no_hashcode"].include?(opt[:no_hashcode])
          _hashcode = nil
        end
        seed += _hashcode.bytes.reduce(:*) unless _hashcode == nil

        return seed, _hashcode
      end

    end

  end
end

