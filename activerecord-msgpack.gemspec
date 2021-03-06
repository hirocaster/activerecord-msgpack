# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/msgpack/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-msgpack"
  spec.version       = ActiveRecord::Msgpack::VERSION
  spec.authors       = ["hirocaster"]
  spec.email         = ["hohtsuka@gmail.com"]
  spec.summary       = %q{Serialize ActiveRecord Object by MessagePack}
  spec.description   = %q{Serialize ActiveRecord Object by MessagePack}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "msgpack"
  spec.add_development_dependency "activerecord"


  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activemodel"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "mysql2"
end
