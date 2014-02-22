# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commaparty/version'

Gem::Specification.new do |spec|
  spec.name          = "commaparty"
  spec.version       = CommaParty::VERSION
  spec.authors       = ["Connor Mendenhall"]
  spec.email         = ["ecmendenhall@gmail.com"]
  spec.description   = %q{A ruby implementation of Clojure's Hiccup markup generation library.}
  spec.summary       = %q{Hiccup, with commas.}
  spec.homepage      = "https://github.com/ecmendenhall/commaparty"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
