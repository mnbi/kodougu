# coding: utf-8
require_relative 'lib/kodougu/version'

Gem::Specification.new do |spec|
  spec.name          = "kodougu"
  spec.version       = Kodougu::VERSION
  spec.authors       = ["mnbi"]
  spec.email         = ["mnbi@users.noreply.github.com"]

  spec.summary       = %q{Small tools}
  spec.description   = %q{Some small tools in your terminal.}
  spec.homepage      = "https://github.com/mnbi/kodougu"
  spec.license       = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mnbi/kodougu"
  spec.metadata["changelog_uri"] = "https://github.com/mnbi/kodougu"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "test-unit", "~> 3.3"

  spec.add_dependency "slop", "~> 4.8"
end
