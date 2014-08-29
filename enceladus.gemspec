# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enceladus/version'

Gem::Specification.new do |spec|
  spec.name          = "enceladus"
  spec.version       = Enceladus::VERSION
  spec.authors       = ["Vinicius Osiro"]
  spec.email         = ["vinicius.osiro@gmail.com"]
  spec.summary       = "Ruby wrapper for the The Movie Database API v3"
  spec.description   = "Ruby wrapper for the The Movie Database API for all endpoints of v3"
  spec.homepage      = "https://github.com/osiro/enceladus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "rest-client", "~> 1.7.2", '>= 1.7.2'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.1 "
  spec.add_development_dependency "byebug", "~> 3.0"
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'webmock', '~> 1.18', '>= 1.18.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4', '>= 0.4.0'
end
