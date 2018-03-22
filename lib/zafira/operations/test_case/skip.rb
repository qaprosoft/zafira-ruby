# frozen_string_literal: true

module Zafira
  module Operations
    module TestCase
      class Skip
        include Concerns::Operationable
        include Finishable

        private

        def handle_test_case_class
          client.skipped_test_case_handler_class
        end

        def fail_test_case_finisning(response)
          dam("TestCase's skip failed: #{response.inspect}")
        end

        def test_case_status
          Models::TestCase::Status::SKIPPED
        end
      end
    end
  end
end
