# frozen_string_literal: true

module Zafira
  module Operations
    module User
      class RefreshToken
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          chain { refresh_token }
          chain { update_token }
        end

        private

        attr_accessor :client, :token

        def refresh_token
          token_response =
            Api::User::RefreshToken.new(client).refresh

          self.token =
            Models::ZafiraToken::Builder.new(token_response).construct

          return if token

          dam("AccessToken's refresh failed: #{token_response.inspect}")
        end

        def update_token
          client.environment.zafira_access_token = token.access_token
          client.environment.refresh_token = token.refresh_token
        end
      end
    end
  end
end
