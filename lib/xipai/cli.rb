

require 'thor'
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  class CLI < Thor

    default_command :help

    desc "version", "Show xipai version"
    def version
      puts Xipai::VERSION
    end

    desc "replay", "replay shuffling with replay-yaml"
    option :"yaml", aliases: "-c", type: :string, desc: "xipai replay config defined yaml file."
    def replay

    end

    desc "sinble", "reproducible based on seeds or random shuffling"
    option :"key-word", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no-hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"replay-output", aliases: "-o", type: :string, desc: ""
    def single()
      xipai(:single, options)
      puts result
    end

    desc "team", "Reproducible based on seeds or random shuffling"
    option :"members", aliases: "-m", type: :integer, desc: "Number of team-members"
    option :"key-word", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no-hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"yaml", aliases: "-y", type: :string, desc: "xipai option defined yaml file."
    option :"config-output", aliases: "-o", type: :string, desc: ""
    def team
      xipai(:team, options)
      puts result
    end

    desc "lottry", "Reproducible based on seeds or random shuffling, then extruct lottery winner."
    option :"winners", aliases: "-m", type: :integer, desc: "Number of winners"
    option :"key-word", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no-hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"yaml", aliases: "-y", type: :string, desc: "xipai option defined yaml file."
    option :"config-output", aliases: "-o", type: :string, desc: ""
    def lottery
      xipai(:lottery, options)
      puts result

    end

    desc "pair", "Reproducible based on seeds or random shuffling, then pairing key-items and value-items."
    option :"winners", aliases: "-m", type: :integer, desc: "Number of winners"
    option :"key-word", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no-hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"key-items", aliases: "-k", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"value-items", aliases: "-v", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"config-output", aliases: "-o", type: :string, desc: ""
    def pair
      xipai(:pair)
      puts result

    end

    private
    def xipai_from_config_file(yaml)

    end

    def xipai(options)
      words = options[:"key-word"].tap {|me|break me.split(",").map(&:strip) unless me.nil? }
      hashcode = options[:hashcode]
      result = Xipai::Core.scrumble!(words, hashcode, yamlfilepath)
    end

  end
end
