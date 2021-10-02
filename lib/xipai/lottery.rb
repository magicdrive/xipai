

require File.expand_path("../xipai/members", File.dirname(__FILE__))
require File.expand_path("../xipai/hashcode", File.dirname(__FILE__))

module Xipai::Lottery

  class << self
    def apply(words, hashcode, yamlfilepath)
      hashcode = Xipai::Hashcode.generate_or_existing(hashcode)

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

