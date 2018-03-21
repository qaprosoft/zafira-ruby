# frozen_string_literal: true

module Zafira
  module Models
    ZafiraToken = Struct.new(:access_token, :refresh_token)

    class ZafiraToken
      class Builder
        def initialize(response)
          self.json = response.parsed_response
          self.code = response.code
        end

        def construct
          return nil if code != 200

          token = ZafiraToken.new
          token.access_token = json['accessToken']
          token.refresh_token = json['refreshToken']
          token
        end

        private

        attr_accessor :json, :code
      end
    end
  end
end
