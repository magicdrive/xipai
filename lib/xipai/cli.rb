
require 'thor'
require File.expand_path("../xipai", File.dirname(__FILE__))
require File.expand_path("../xipai/lottery", File.dirname(__FILE__))
class xipai::CLI < Thor

  desc "jimei", "`lottery the turn` tool"
  option :"word1", aliases: "-w1", type: :string, required: true
  option :"word2", aliases: "-w2", type: :string, required: true
  option :"word3", aliases: "-w3", type: :string, required: true
  option :"hashcode", aliases: "-c", type: :string
  option :"yaml", aliases: "-y", type: :string, required: true
  def jimei()
    words = [options[:word1], options[:word2], options[:word3]]
    hashcode = options[:hashcode]
    yamlfilepath = options[:yaml]
    result = Xipai::Lottery.apply(words, hashcode, yamlfilepath)
    puts result
  end

end
