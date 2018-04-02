# frozen_string_literal: true

module Zafira
  module Operations
    module TestCase
      module Finishable
        include Concerns::Operationable

        def initialize(client, test_case_result)
          self.client = client
          self.test_case_result = test_case_result
        end

        def call
          super do
            chain { init_end_time }
            chain { finish_test_case }
          end
        end

        private

        attr_accessor :client, :test_case_result

        def init_end_time
          client.current_test_case.end_time = Time.now
        end

        def finish_test_case
          handled_result =
            Handlers::FinishedTestCaseHandler.new(
              zafira_handle_test_case_class, handle_test_case_class,
              client.current_test_case, test_case_result,
              test_case_status
            )

          test_case_response =
            Api::TestCase::Finish.new(client, handled_result).finish

          return if test_case_response.code == 200

          fail_test_case_finisning(test_case_response)
        end

        def handle_test_case_class
          raise NotImplementedError
        end

        def zafira_handle_test_case_class
          raise NotImplementedError
        end

        def fail_test_case_finisning(_response)
          raise NotImplementedError
        end

        def test_case_status
          raise NotImplementedError
        end
      end
    end
  end
end
