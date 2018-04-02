# frozen_string_literal: true

module Cucumber
  class Configuration
    def zafira_test_case_handler_class
      Zafira::Handlers::TestCase::Cucumber
    end

    def zafira_failed_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Failed
    end

    def zafira_skipped_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Skipped
    end

    def zafira_passed_test_case_handler_class
      Zafira::Handlers::FinishedTestCase::Cucumber::Passed
    end
  end
end
