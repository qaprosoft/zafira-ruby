# frozen_string_literal: true

module Zafira
  module Api
    module TestCase
      class Finish
        include Concerns::Apiable

        def initialize(client, wrapped_test_case_status)
          super(client)

          self.wrapped_test_case_status =
            wrapped_test_case_status
        end

        def finish
          retryable { HTTParty.post(*requets_params) }
        end

        private

        attr_accessor :wrapped_test_case_status

        def requets_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint "/api/tests/#{client.current_test_case.test_id}/finish"
        end

        def body
          {
            testCaseId: client.current_test_case.test_case_id,
            name: client.current_test_case.info,
            testRunId: client.run.id
          }.merge(wrapped_params).to_json
        end

        def wrapped_params
          {
            status: wrapped_test_case_status.status,
            message: wrapped_test_case_status.message
          }.merge(timings)
        end

        def timings
          {
            runTime: wrapped_test_case_status.start_time.to_i,
            finishTime: wrapped_test_case_status.end_time.to_i
          }
        end
      end
    end
  end
end
