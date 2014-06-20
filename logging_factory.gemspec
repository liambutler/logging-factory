# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name          = 'logging_factory'
  gem.version       = LoggingFactory::VERSION
  gem.authors       = ['Nayyara Samuel']
  gem.email         = ['nayyara.samuel@opower.com']
  gem.description   = %q(A wrapper around logging gem)
  gem.summary       = %q(A wrapper around logging gem)

  gem.files = `git ls-files -z`.split("\x0")
  gem.executables = gem.files.grep(/^bin\//) { |f| File.basename(f) }
  gem.test_files = gem.files.grep(/^(test|spec|features)\//)
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 10.3.2'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
  gem.add_development_dependency 'rubocop', '~> 0.23.0'
  gem.add_development_dependency 'simplecov', '~> 0.6.4'

  gem.add_dependency 'logging', '~> 1.8.1'
  gem.add_dependency 'preconditions', '~> 0.3.0'
end
