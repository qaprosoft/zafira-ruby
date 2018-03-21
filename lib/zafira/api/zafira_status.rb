# frozen_string_literal: true

module Zafira
  module Api
    class ZafiraStatus
      include Concerns::Apiable

      STATUS_ENDPOINT = '/api/status'

      def get
        HTTParty.get(api_endpoint(STATUS_ENDPOINT))
      end
    end
  end
end
