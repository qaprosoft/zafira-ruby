# frozen_string_literal: true

module Zafira
  module Concerns
    module Apiable
      def initialize(client)
        self.client = client
        # init env just not to make the code spagetty
        self.environment = client.environment
      end

      private

      def api_endpoint(path)
        environment.zafira_api_url + path
      end

      def retryable
        response = yield

        # means that token is ok
        # UGLY. but zafira doesnt return good json.so have to handle 500
        # so dont touch :)
        if response.code == 401 || response.code == 500
          # we have to refresh token
          Operations::User::RefreshToken.new(client).call
          response = yield
        end

        response
      end

      # basic header params
      def headers
        params = { 'Content-Type' => 'Application/json' }
        if environment.zafira_access_token
          params['Authorization'] = 'Bearer ' + environment.zafira_access_token
        end

        if environment.zafira_project_name
          params['Project'] = environment.zafira_project_name
        end

        params
      end

      attr_accessor :client, :environment
    end
  end
end
