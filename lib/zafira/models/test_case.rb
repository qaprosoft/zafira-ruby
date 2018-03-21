# frozen_string_literal: true

module Zafira
  module Models
    class TestCase
      attr_accessor :test_id, :test_case_id, :test_class, :test_method,
                    :info, :test_suite_id, :primary_owner_id, :run_id,
                    :start_time, :end_time

      module Status
        UNKNOWN = 0
        IN_PROGRESS = 1
        PASSED = 2
        FAILED = 3
        SKIPPED = 4
        ABORTED = 5
      end

      class Builder
        def initialize(client, test_case)
          # wrapped example should respond to
          # [:test_class, :test_method, :info]
          self.wrapped_example = client.test_case_handler_class.new(test_case)
          self.test_suite_id = client.test_suite.id
          self.primary_owner_id = client.test_suite_owner.id
          self.run_id = client.run.id
        end

        def construct
          test_case = TestCase.new

          # from wrapped example
          test_case.test_class = wrapped_example.test_class
          test_case.test_method = wrapped_example.test_method
          test_case.info = wrapped_example.info

          # from environment
          test_case.test_suite_id = test_suite_id
          test_case.primary_owner_id = primary_owner_id
          test_case.run_id = run_id

          # return test case
          test_case
        end

        private

        attr_accessor :wrapped_example, :test_suite_id,
                      :primary_owner_id, :run_id
      end
    end
  end
end
