# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logging_factory/version'

Gem::Specification.new do |gem|
  gem.name          = 'logging_factory'
  gem.version       = Opower::LoggingFactory::VERSION
  gem.authors       = ["Nayyara Samuel"]
  gem.email         = ["nayyara.samuel@opower.com"]
  gem.description   = %q{A wrapper around logging gem}
  gem.summary       = %q{A wrapper around logging gem}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'logging'
  gem.add_dependency 'load_path'
  gem.add_dependency 'preconditions'
end
