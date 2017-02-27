# coding: utf-8
lib = File.expand_path "../lib", __FILE__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "nav/logger/version"

Gem::Specification.new do |spec|
  spec.name          = "nav-logger"
  spec.version       = Nav::Logger::VERSION
  spec.authors       = ["JohnnyT"]
  spec.email         = ["ubergeek3141@gmail.com"]

  spec.summary       = "Nav's logger"
  spec.homepage      = "https://github.com/creditera/nav-logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fluent-logger", "~> 0.6.1"
  spec.add_dependency "request_store", "~> 1.3.2"
end
