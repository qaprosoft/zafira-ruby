# frozen_string_literal: true

require 'bundler/setup'
require 'zafira/ruby'
require_relative 'formatter'

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.expose_dsl_globally = true

  config.add_setting(
    :test_case_handler_class,
    default: Zafira::Handlers::TestCase::Rspec
  )

  config.add_setting(
    :failed_test_case_handler_class,
    default: Zafira::Handlers::FinishedTestCase::Rspec::Failed
  )

  config.add_setting(
    :skipped_test_case_handler_class,
    default: Zafira::Handlers::FinishedTestCase::Rspec::Skipped
  )

  config.add_setting(
    :passed_test_case_handler_class,
    default: Zafira::Handlers::FinishedTestCase::Rspec::Passed
  )
end
