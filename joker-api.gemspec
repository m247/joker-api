# -*- encoding: utf-8 -*-
require File.expand_path('../lib/joker-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Geoff Garside"]
  gem.email         = ["geoff@geoffgarside.co.uk"]
  gem.description   = %q{Joker.com domain registration API client}
  gem.summary       = %q{Joker.com API client}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "joker-api"
  gem.require_paths = ["lib"]
  gem.version       = JokerAPI::VERSION

  gem.add_dependency 'httparty'
  gem.add_dependency 'activesupport'
end
