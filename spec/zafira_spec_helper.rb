# frozen_string_literal: true

require 'factory_bot'
require 'support/factory_bot'
require 'zafira/ruby'
require 'zafira/rspec/formatter'
require 'zafira/cucumber/formatter'

include WebMock::API
WebMock.enable!
