

require 'thor'
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  class CLI < Thor

    default_command :help

    desc "version", "Show xipai version"
    def version
      puts Xipai::VERSION
    end

    desc "replay", "Replay shuffling with xipai-replay yaml"
    option :"yaml", aliases: "-c", type: :string, desc: "xipai replay config defined yaml file."
    option :"replay_output", aliases: "-o", type: :string, desc: "output xipai-replay yaml to specified path"
    def replay
      xipai = Xipai::TableSet.parse_yaml(options[:yaml])
      result = xipai.apply

      puts result
      xipai.dump_replay_yaml(options[:replay_output]) unless options[:replay_output].nil?

    end

    desc "single", "reproducible based on seeds or random shuffling."
    option :"key_words", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no_hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty", aliases: "-p", type: :string, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string, desc: "output xeplay-replay yaml to specified path"
    def single()
      xipai = Xipai::TableSet.parse_options(:single, options)
      result = xipai.apply

      puts result
      xipai.dump_replay_yaml(options[:replay_output]) unless options[:replay_output].nil?

    end

    desc "team", "Reproducible based on seeds or random shuffling, then create teams"
    option :"members", aliases: "-m", type: :numeric, desc: "Number of team-members"
    option :"key_words", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no_hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty", aliases: "-p", type: :string, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string, desc: "output xeplay-replay yaml to specified path"
    def team
      xipai = Xipai::TableSet.parse_options(:team, options)
      result = xipai.apply

      puts result
      xipai.dump_replay_yaml(options[:replay_output]) unless options[:replay_output].nil?
    end

    desc "lottery", "Reproducible based on seeds or random shuffling, then extruct lottery winner."
    option :"winners", aliases: "-m", type: :numeric, desc: "Number of winners"
    option :"key_words", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no_hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"items", aliases: "-a", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty", aliases: "-p", type: :string, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string, desc: "output xeplay-replay yaml to specified path"
    def lottery
      xipai = Xipai::TableSet.parse_options(:lottery, options)
      result = xipai.apply

      puts result
      xipai.dump_replay_yaml(options[:replay_output]) unless options[:replay_output].nil?

    end

    desc "pair", "Reproducible based on seeds or random shuffling, then pairing key-items and value-items."
    option :"key-words", aliases: "-w", type: :string, desc: "Comma-separated seed string"
    option :"hashcode", aliases: "-c", type: :string, desc: "Hashcode to identify this randomization"
    option :"no_hashcode",  aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization"
    option :"key_items", aliases: "-k", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"value_items", aliases: "-v", type: :string, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty", aliases: "-p", type: :string, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string, desc: "output xeplay-replay yaml to specified path"
    def pair
      xipai = Xipai::TableSet.parse_options(:pair, options)
      result = xipai.apply

      puts result
      xipai.dump_replay_yaml(options[:replay_output]) unless options[:replay_output].nil?

    end


  end
end
