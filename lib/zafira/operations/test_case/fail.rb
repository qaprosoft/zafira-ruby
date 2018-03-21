# frozen_string_literal: true

module Zafira
  module Operations
    module TestCase
      class Fail
        include Concerns::Operationable
        include Finishable

        private

        def handle_test_case_class
          client.failed_test_case_handler_class
        end

        def fail_test_case_finisning(response)
          dam("TestCase's fail failed: #{response.inspect}")
        end
      end
    end
  end
end
