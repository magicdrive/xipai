# frozen_string_literal: true

require "digest/sha2"
require "time"
require "securerandom"


module Xipai
  module Hashcode
    class << self

      def random_hashcode()
        digit_seed = "#{self.name.object_id}-#{$$}-#{Time.now.to_i}-#{SecureRandom.hex(16)}-#{SecureRandom.hex(16)}}"
        _hashcode_ = Digest::SHA256.hexdigest(digit_seed)[0 .. 16]
        return _hashcode_
      end

      def generate_or_existing(hashcode)
        return random_hashcode if hashcode.nil?
        return hashcode
      end
    end

  end
end

