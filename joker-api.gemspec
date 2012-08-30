# -*- encoding: utf-8 -*-
require File.expand_path('../lib/joker-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Geoff Garside"]
  gem.email         = ["geoff@geoffgarside.co.uk"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "joker-api"
  gem.require_paths = ["lib"]
  gem.version       = JokerAPI::VERSION
end
