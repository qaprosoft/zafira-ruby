# frozen_string_literal: true

module Zafira
  module Api
    module User
      class Create
        class TestSuiteOwnerParams
          def initialize(environment)
            self.environment = environment
          end

          def construct
            {
              username: environment.test_suite_username,
              email: environment.test_suite_email,
              first_name: environment.test_suite_first_name,
              last_name: environment.test_suite_last_name
            }
          end

          private

          attr_accessor :environment
        end
      end
    end
  end
end
