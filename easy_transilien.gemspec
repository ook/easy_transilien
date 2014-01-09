# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_transilien/version'

Gem::Specification.new do |gem|
  gem.name          = "easy_transilien"
  gem.version       = EasyTransilien::VERSION
  gem.authors       = ["Thomas Lecavelier"]
  gem.email         = ["thomas-gems@lecavelier.name"]
  gem.description   = %q{Access SNCF Transilien micro-services datan the easy way: enable access to their theoric offer.}
  gem.summary       = %q{See https://github.com/ook/easy_transilien}
  gem.homepage      = "https://github.com/ook/easy_transilien"
  gem.license       = 'MIT'

  gem.add_runtime_dependency('transilien_microservices',  '~> 0.0.6') # Hey, it's a wrapper, so we must wrap it ;)

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
