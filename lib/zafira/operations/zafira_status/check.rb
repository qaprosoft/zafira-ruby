# frozen_string_literal: true

module Zafira
  module Operations
    module ZafiraStatus
      class Check
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { load_status }
            chain { validate_status }
          end
        end

        private

        attr_accessor :zafira, :client

        def load_status
          status_response = Api::ZafiraStatus.new(client).get

          self.zafira =
            Models::ZafiraStatus::Builder.new(status_response).construct
        end

        def validate_status
          if zafira&.available
            logger.info('Zafira is available.')
            return
          end

          dam("Zafira(#{client&.environment&.zafira_api_url}) is not available")
        end
      end
    end
  end
end
