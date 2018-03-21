# frozen_string_literal: true

module Zafira
  module Api
    module Run
      class Start
        include Concerns::Apiable

        RUN_START_ENDPOINT = '/api/tests/runs'

        def initialize(client, started_by, driver_mode)
          super(client)

          self.started_by = started_by
          self.driver_mode = driver_mode
        end

        def start
          retryable { HTTParty.post(*request_params) }
        end

        private

        attr_accessor :started_by, :driver_mode

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(RUN_START_ENDPOINT)
        end

        def body
          {
            startedBy: started_by,
            driverMode: driver_mode
          }.merge(client_params).merge(environment_params).to_json
        end

        def client_params
          {
            testSuiteId: client.test_suite.id,
            jobId: client.job.id,
            userId: client.run_owner.id
          }
        end

        def environment_params
          {
            ciRunId: environment.ci_test_run_uuid,
            buildNumber: environment.ci_run_build_number,
            configXML: XmlConfigBuilder.new(environment).construct.to_s
          }
        end
      end
    end
  end
end
