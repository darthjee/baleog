# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baleog/version'

Gem::Specification.new do |gem|
  gem.name                  = 'baleog'
  gem.version               = Baleog::VERSION
  gem.authors               = ['DarthJee']
  gem.email                 = ['darthjee@gmail.com']
  gem.homepage              = 'https://github.com/darthjee/baleog'
  gem.description           = ''
  gem.summary               = gem.description
  gem.required_ruby_version = '>= 2.7.0'

  gem.files                 = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables           = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.require_paths         = ['lib']

  gem.add_runtime_dependency 'faraday',  '2.7.4'
  gem.add_runtime_dependency 'sinclair', '>= 2.0.1'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
