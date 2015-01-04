# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "multi_smtp/version"

Gem::Specification.new do |spec|
  spec.name          = "multi_smtp"
  spec.version       = MultiSMTP::VERSION
  spec.authors       = ["Harlow Ward"]
  spec.email         = ["harlow@hward.com"]
  spec.summary       = %q{Email failover in Rails with MultiSMTP}
  spec.description   = %q{Email failover in Rails with MultiSMTP}
  spec.homepage      = "https://github.com/harlow/multi_smtp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mail", "~> 2.6.3"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
