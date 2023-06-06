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

  gem.add_development_dependency 'bundler',            '>= 2.3.25'
  gem.add_development_dependency 'factory_bot',        '6.2.1'
  gem.add_development_dependency 'pry',                '0.14.1'
  gem.add_development_dependency 'pry-nav',            '1.0.0'
  gem.add_development_dependency 'rake',               '13.0.6'
  gem.add_development_dependency 'reek',               '6.1.4'
  gem.add_development_dependency 'rspec',              '3.12.0'
  gem.add_development_dependency 'rspec-core',         '3.12.2'
  gem.add_development_dependency 'rspec-expectations', '3.12.3'
  gem.add_development_dependency 'rspec-mocks',        '3.12.5'
  gem.add_development_dependency 'rspec-support',      '3.12.0'
  gem.add_development_dependency 'rubocop',            '1.51.0'
  gem.add_development_dependency 'rubocop-rspec',      '2.22.0'
  gem.add_development_dependency 'rubycritic',         '4.8.0'
  gem.add_development_dependency 'simplecov',          '0.22.0'
  gem.add_development_dependency 'webmock',            '3.18.1'
  gem.add_development_dependency 'yard',               '0.9.34'
  gem.add_development_dependency 'yardstick',          '0.9.9'

  gem.add_runtime_dependency 'faraday',  '2.7.4'
  gem.add_runtime_dependency 'sinclair', '>= 2.0.1'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
