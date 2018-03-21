# frozen_string_literal: true

module Zafira
  module Api
    module TestSuite
      class Create
        include Concerns::Apiable

        CREATE_ENDPOINT = '/api/tests/suites'

        def create
          retryable { HTTParty.post(*request_params) }
        end

        private

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(CREATE_ENDPOINT)
        end

        def body
          {
            name: environment.test_suite_name,
            fileName: environment.test_suite_config_file,
            description: environment.test_suite_description,
            userId: client.test_suite_owner.id
          }.to_json
        end
      end
    end
  end
end
