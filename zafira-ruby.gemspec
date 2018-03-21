
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zafira/ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'zafira-ruby'
  spec.version       = Zafira::Ruby::VERSION
  spec.authors       = ['Aliaksei Khursevich', 'Yahor Zhylinski']
  spec.email         = ['alex@qaprosoft.com']

  spec.summary       = 'Zafira listener for RSpec and Cucumber.'

  spec.description   = 'Zafira QA Automation Reporting listener for' \
                       'Rspec and Cucumber based on formatters.' \

  spec.homepage      = 'https://github.com/qaprosoft/zafira-ruby'
  spec.license       = 'Apache Software License v2.0'

  spec.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  spec.require_path = 'lib'

  spec.add_dependency 'waterfall'
  spec.add_dependency 'builder'
  spec.add_dependency 'httparty'
  spec.add_dependency 'webmock'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'factory_bot'
end
