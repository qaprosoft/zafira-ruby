# frozen_string_literal: true

module Zafira
  module Api
    module Job
      class Start
        include Concerns::Apiable

        START_ENDPOINT = '/api/jobs'

        def start
          retryable { HTTParty.post(*request_params) }
        end

        private

        attr_accessor :client

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(START_ENDPOINT)
        end

        def body
          {
            name: environment.ci_job_name,
            userId: client.run_owner.id,
            jobURL: environment.ci_job_url,
            jenkinsHost: environment.ci_host
          }.to_json
        end
      end
    end
  end
end
