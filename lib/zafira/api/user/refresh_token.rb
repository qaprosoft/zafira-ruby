# frozen_string_literal: true

module Zafira
  module Api
    module User
      class RefreshToken
        include Concerns::Apiable

        REFRESH_TOKEN_ENDPOINT = '/api/auth/refresh'

        def refresh
          HTTParty.post(*request_params)
        end

        private

        def request_params
          [endpoint, body: body, headers: headers_without_authorization]
        end

        def endpoint
          api_endpoint(REFRESH_TOKEN_ENDPOINT)
        end

        def body
          { refreshToken: refresh_token }.to_json
        end

        def refresh_token
          environment.refresh_token || environment.zafira_access_token
        end
      end
    end
  end
end
