# frozen_string_literal: true

module Zafira
  module Api
    module TestCase
      class Create
        include Concerns::Apiable

        CREATE_ENDPOINT = '/api/tests/cases'

        def initialize(client)
          super(client)
          self.current_test_case = client.current_test_case
        end

        def create
          retryable { HTTParty.post(*request_params) }
        end

        private

        attr_accessor :current_test_case

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(CREATE_ENDPOINT)
        end

        def body
          {
            testClass: current_test_case.test_class,
            testMethod: current_test_case.test_method,
            info: current_test_case.info,
            testSuiteId: current_test_case.test_suite_id,
            primaryOwnerId: current_test_case.primary_owner_id
          }.to_json
        end
      end
    end
  end
end
