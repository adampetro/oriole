# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "oriole/version"

Gem::Specification.new do |spec|
  spec.name          = "oriole"
  spec.version       = Oriole::VERSION
  spec.authors       = ["Adam Petro"]
  spec.email         = ["adamapetro@gmail.com"]

  spec.summary       = "A fast GraphQL engine written in pure Ruby."
  spec.description   = "A fast GraphQL engine written in pure Ruby."
  spec.homepage      = "https://github.com/adampetro/oriole"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/adampetro/oriole"
  spec.metadata["changelog_uri"] = "https://github.com/adampetro/oriole/blob/main/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 2.4.10")
  spec.add_development_dependency("minitest", "~> 5.0")
  spec.add_development_dependency("rake", "~> 13.0")

  spec.add_dependency("sorbet-runtime", "~> 0.5")
  spec.add_dependency("tinygql", "~> 0.1.4")
  spec.add_dependency("zeitwerk", "~> 2.6")
end
