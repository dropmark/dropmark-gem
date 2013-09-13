# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropmark/version'

Gem::Specification.new do |gem|
  gem.name          = "Dropmark"
  gem.version       = Dropmark::VERSION
  gem.authors       = ["dropmark"]
  gem.email         = ["api@dropmark.com"]
  gem.description   = %q{A Ruby interface and command line utility for the Dropmark API.}
  gem.summary       = "Dropmark Ruby interface"
  gem.homepage      = "http://dropmark.com"
  
  gem.required_ruby_version = '>= 1.8'
  
  gem.add_runtime_dependency 'her'
  gem.add_runtime_dependency 'mime-types'

  gem.files         = `git ls-files`.split($/)
  gem.files         += Dir.glob("lib/**/*.rb")
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
