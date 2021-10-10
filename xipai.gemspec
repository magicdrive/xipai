# frozen_string_literal: true

require_relative "lib/xipai/version"

Gem::Specification.new do |spec|
  spec.name          = "xipai"
  spec.version       = Xipai::VERSION
  spec.authors       = ["Hiroshi IKEGAMI"]
  spec.email         = ["hiroshi.ikegami@magicdrive.jp"]

  spec.summary       = "Reproducible based on seeds or random shuffling tool."
  spec.description   = "Reproducible based on seeds or random shuffling tool."
  spec.homepage      = "https://github.com/magicdrive/xipai"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }

  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'thor', '>= 1.0'
  spec.add_runtime_dependency 'optional', '>= 0.0.7'
  spec.add_runtime_dependency 'hashie', '>= 2.0'
  spec.add_runtime_dependency 'pry', '>= 0.0.0'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
