# frozen_string_literal: true

require 'thor'
require 'fileutils'
require File.expand_path("../xipai", File.dirname(__FILE__))

module Xipai
  class CLI < Thor

    default_command :help

    desc "version", "Show xipai version"
    def version
      $stdout.puts Xipai::VERSION
    end

    desc "replay", "Replay shuffling with xipai-replay yaml"
    option :"replay_yaml",   aliases: "-c", type: :string, required: true, desc: "Xipai replay config defined yaml file."
    option :"replay_output", aliases: "-o", type: :string, default: "",    desc: "Output xipai-replay yaml to specified path"
    def replay()
      finalize Xipai.replay!(File.read(options[:"replay_yaml"]), options)
    end

    desc "single", "Reproducible based on seeds or random shuffling."
    option :"key_words",     aliases: "-w", type: :string,  default: "",    desc: "Comma-separated seed string"
    option :"hashcode",      aliases: "-c", type: :string,  default: "",    desc: "Hashcode to identify this randomization"
    option :"no_hashcode",   aliases: "-n", type: :boolean, default: false, desc: "Do not use hashcode for randomization"
    option :"items",         aliases: "-A", type: :string,  required: true, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty",        aliases: "-p", type: :boolean, default: false, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string,  default: "",    desc: "Output xeplay-replay yaml to specified path"
    option :"verbose",       aliases: "-v", type: :boolean, default: false, desc: "Verbose mode Output"
    def single()
      finalize Xipai.lets_do_this!(:single, options)
    end

    desc "team", "Reproducible based on seeds or random shuffling, then create teams"
    option :"number_of_members", aliases: "-m", type: :numeric, required: true, desc: "Number of team-members"
    option :"key_words",         aliases: "-w", type: :string,  default: "",    desc: "Comma-separated seed string"
    option :"hashcode",          aliases: "-c", type: :string,  default: "",    desc: "Hashcode to identify this randomization"
    option :"no_hashcode",       aliases: "-n", type: :boolean, default: false, desc: "Do not use hashcode for randomization"
    option :"items",             aliases: "-A", type: :string,  required: true, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty",            aliases: "-p", type: :boolean, default: false, desc: "Pretty print output."
    option :"replay_output",     aliases: "-o", type: :string,  default: "",    desc: "Output xeplay-replay yaml to specified path"
    option :"verbose",           aliases: "-v", type: :boolean, default: false, desc: "Verbose mode Output"
    def team()
      finalize Xipai.lets_do_this!(:team, options)
    end

    desc "lottery", "Reproducible based on seeds or random shuffling, then extruct lottery winner."
    option :"number_of_winners", aliases: "-m", type: :numeric, required: true, desc: "Number of winners"
    option :"key_words",         aliases: "-w", type: :string,  default: "",    desc: "Comma-separated seed string"
    option :"hashcode",          aliases: "-c", type: :string,  default: "",    desc: "Hashcode to identify this randomization"
    option :"no_hashcode",       aliases: "-n", type: :boolean, default: false, desc: "Do not use hashcode for randomization"
    option :"items",             aliases: "-A", type: :string,  required: true, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty",            aliases: "-p", type: :boolean, default: false, desc: "Pretty print output."
    option :"replay_output",     aliases: "-o", type: :string,  default: "",    desc: "Output xeplay-replay yaml to specified path"
    option :"verbose",           aliases: "-v", type: :boolean, default: false, desc: "Verbose mode Output"
    def lottery()
      finalize Xipai.lets_do_this!(:lottery, options)
    end

    desc "pair", "Reproducible based on seeds or random shuffling, then pairing key-items and value-items."
    option :"key_words",     aliases: "-w", type: :string,  default: "",    desc: "Comma-separated seed string"
    option :"hashcode",      aliases: "-c", type: :string,  default: "",    desc: "Hashcode to identify this randomization"
    option :"no_hashcode",   aliases: "-n", type: :boolean, default: false, desc: "Do not use hashcode for randomization"
    option :"key_items",     aliases: "-K", type: :string,  required: true, desc: "Items to be shuffled. (comma-separated)"
    option :"value_items",   aliases: "-V", type: :string,  required: true, desc: "Items to be shuffled. (comma-separated)"
    option :"pretty",        aliases: "-p", type: :boolean, default: false, desc: "Pretty print output."
    option :"replay_output", aliases: "-o", type: :string,  default: "",    desc: "Output xeplay-replay yaml to specified path"
    option :"verbose",       aliases: "-v", type: :boolean, default: false, desc: "Verbose mode Output"
    def pair()
      finalize Xipai.lets_do_this!(:pair, options)
    end

    private
    def finalize(xipai_result)
      $stdout.puts xipai_result.data_json
      dump_replay_yaml(xipai_result) if xipai_result.replay_output?
    end

    def dump_replay_yaml(xipai_result)
      raise "error: replay_yaml path is nil." if xipai_result.replay_output_path.nil?
      FileUtils.mkdir_p(File.dirname(xipai_result.replay_output_path))
      YAML.dump(xipai_result.replay_data, File.open(xipai_result.replay_output_path, "w"))
    end

  end
end
