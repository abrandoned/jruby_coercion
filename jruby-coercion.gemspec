# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jruby-coercion/version'

Gem::Specification.new do |gem|
  gem.name          = "jruby-coercion"
  gem.version       = Jruby::Coercion::VERSION
  gem.authors       = ["Brandon Dewitt"]
  gem.email         = ["brandonsdewitt+jrubycoercion@gmail.com"]
  gem.description   = %q{ gem to facilitate automatic coercion between jruby/java objects }
  gem.summary       = %q{ helps coerce ruby objects into java type automatically }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.platform      = "java"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry-nav"
end
