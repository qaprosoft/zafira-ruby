# frozen_string_literal: true

module Zafira
  module Api
    module Run
      class Finish
        include Concerns::Apiable

        def finish
          retryable { HTTParty.post(*request_params) }
        end

        private

        def request_params
          [endpoint, headers: headers]
        end

        def endpoint
          api_endpoint("/api/tests/runs/#{client.run.id}/finish")
        end
      end
    end
  end
end
