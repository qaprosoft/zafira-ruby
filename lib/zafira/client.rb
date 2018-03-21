# frozen_string_literal: true

module Zafira
  class Client
    attr_accessor :environment, :run_owner, :test_suite_owner,
                  :test_suite, :job, :run, :current_test_case, :unavailable

    # wrappers
    attr_accessor :test_case_handler_class,
                  :failed_test_case_handler_class,
                  :skipped_test_case_handler_class,
                  :passed_test_case_handler_class

    def initialize(config)
      self.test_case_handler_class =
        config.test_case_handler_class

      self.failed_test_case_handler_class =
        config.failed_test_case_handler_class

      self.skipped_test_case_handler_class =
        config.skipped_test_case_handler_class

      self.passed_test_case_handler_class =
        config.passed_test_case_handler_class
    end

    def enabled?
      # enabled if environment not set yet
      # or it's enabled by the var zafira_enabled
      environment&.zafira_enabled || !environment
    end

    def disabled?
      !enabled?
    end
  end
end
