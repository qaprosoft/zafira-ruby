# frozen_string_literal: true

module Zafira
  module Api
    module User
      class Create
        include Concerns::Apiable

        CREATE_ENDPOINT = '/api/users'

        UNKNOWN_USER = 'unknown'

        def initialize(client, params)
          super(client)
          self.params = params
        end

        def create
          retryable { HTTParty.put(*request_params) }
        end

        private

        attr_accessor :params

        def request_params
          [endpoint, body: body, headers: headers]
        end

        def endpoint
          api_endpoint(CREATE_ENDPOINT)
        end

        def body
          {
            username: params[:username] || UNKNOWN_USER,
            email: params[:email],
            firstName: params[:first_name],
            lastName: params[:last_name]
          }.to_json
        end
      end
    end
  end
end
