

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
    option :"replay_yaml",   aliases: "-c", type: :string, desc: "xipai replay config defined yaml file.", required: true
    option :"replay_output", aliases: "-o", type: :string, desc: "output xipai-replay yaml to specified path"
    def replay
      Xipai.replay!(File.read(options), options)
    end

    desc "single", "Reproducible based on seeds or random shuffling."
    option :"key_words",     aliases: "-w", type: :string,  desc: "Comma-separated seed string"
    option :"hashcode",      aliases: "-c", type: :string,  desc: "Hashcode to identify this randomization"
    option :"no_hashcode",   aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization", default: false
    option :"items",         aliases: "-a", type: :string,  desc: "Items to be shuffled. (comma-separated)", required: true
    option :"pretty",        aliases: "-p", type: :boolean, desc: "Pretty print output.", default: false
    option :"replay_output", aliases: "-o", type: :string,  desc: "output xeplay-replay yaml to specified path"
    def single()
      Xipai.lets_do_this!(:single, options)
    end

    desc "team", "Reproducible based on seeds or random shuffling, then create teams"
    option :"number_of_members", aliases: "-m", type: :numeric, desc: "Number of team-members", required: true
    option :"key_words",         aliases: "-w", type: :string,  desc: "Comma-separated seed string", required: true
    option :"hashcode",          aliases: "-c", type: :string,  desc: "Hashcode to identify this randomization"
    option :"no_hashcode",       aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization", default: false
    option :"items",             aliases: "-a", type: :string,  desc: "Items to be shuffled. (comma-separated)", required: true
    option :"pretty",            aliases: "-p", type: :boolean, desc: "Pretty print output.", default: false
    option :"replay_output",     aliases: "-o", type: :string,  desc: "output xeplay-replay yaml to specified path"
    def team
      Xipai.lets_do_this!(:team, options)
    end

    desc "lottery", "Reproducible based on seeds or random shuffling, then extruct lottery winner."
    option :"number_of_winners", aliases: "-m", type: :numeric, desc: "Number of winners", required: true
    option :"key_words",         aliases: "-w", type: :string,  desc: "Comma-separated seed string"
    option :"hashcode",          aliases: "-c", type: :string,  desc: "Hashcode to identify this randomization"
    option :"no_hashcode",       aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization", default: false
    option :"items",             aliases: "-a", type: :string,  desc: "Items to be shuffled. (comma-separated)", required: true
    option :"pretty",            aliases: "-p", type: :boolean, desc: "Pretty print output.", default: false
    option :"replay_output",     aliases: "-o", type: :string,  desc: "output xeplay-replay yaml to specified path"
    def lottery
      Xipai.lets_do_this!(:lottery, options)
    end

    desc "pair", "Reproducible based on seeds or random shuffling, then pairing key-items and value-items."
    option :"key_words",     aliases: "-w", type: :string,  desc: "Comma-separated seed string"
    option :"hashcode",      aliases: "-c", type: :string,  desc: "Hashcode to identify this randomization"
    option :"no_hashcode",   aliases: "-n", type: :boolean, desc: "Do not use hashcode for randomization", default: false
    option :"key_items",     aliases: "-k", type: :string,  desc: "Items to be shuffled. (comma-separated)", required: true
    option :"value_items",   aliases: "-v", type: :string,  desc: "Items to be shuffled. (comma-separated)", required: true
    option :"pretty",        aliases: "-p", type: :boolean, desc: "Pretty print output.", default: false
    option :"replay_output", aliases: "-o", type: :string,  desc: "output xeplay-replay yaml to specified path"
    def pair
      Xipai.lets_do_this!(:pair, options)
    end

  end
end
