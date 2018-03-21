# frozen_string_literal: true

module Zafira
  module Models
    User = Struct.new(:id, :username)

    class User
      module Type
        RUN_OWNER = :run_owner
        TEST_SUITE_OWNER = :test_suite_owner
      end

      class Builder
        def initialize(response)
          self.json = response.parsed_response
          self.code = response.code
        end

        def construct
          return nil if code != 200

          user = User.new
          user.id = json['id']
          user.username = json['username']
          user
        end

        private

        attr_accessor :json, :code
      end
    end
  end
end
