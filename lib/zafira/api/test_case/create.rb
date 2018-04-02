# frozen_string_literal: true

module Zafira
  module Api
    module TestCase
      class Create
        include Concerns::Apiable

        CREATE_ENDPOINT = '/api/tests/cases'

        def initialize(client, wrapped_test_case)
          super(client)
          self.wrapped_test_case = wrapped_test_case
        end

        def create
          retryable { HTTParty.post(*request_params) }
        end

        private

        attr_accessor :wrapped_test_case

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(CREATE_ENDPOINT)
        end

        def body
          {
            testClass: wrapped_test_case.test_class,
            testMethod: wrapped_test_case.test_method,
            info: wrapped_test_case.info,
            testSuiteId: client.current_test_case.test_suite_id,
            primaryOwnerId: client.current_test_case.primary_owner_id
          }.to_json
        end
      end
    end
  end
end
