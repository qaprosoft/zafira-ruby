# frozen_string_literal: true

module Zafira
  module Api
    module TestCase
      class Start
        include Concerns::Apiable

        START_ENDPOINT = '/api/tests'

        def start
          retryable { HTTParty.post(*request_params) }
        end

        private

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(START_ENDPOINT)
        end

        def body
          {
            testCaseId: client.current_test_case.test_case_id,
            name: client.current_test_case.info,
            status: Models::TestCase::Status::IN_PROGRESS,
            testRunId: client.current_test_case.run_id
          }.to_json
        end
      end
    end
  end
end
