# frozen_string_literal: true

module Cucumber
  class Configuration
    def test_case_handler_class
      Zafira::Handlers::TestCase::Cucumber
    end

    def failed_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Failed
    end

    def skipped_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Skipped
    end

    def passed_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Passed
    end
  end
end
