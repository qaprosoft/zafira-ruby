# frozen_string_literal: true

module Zafira
  module Operations
    module TestCase
      class Create
        include Concerns::Operationable

        def initialize(client, test_case)
          self.client = client
          self.test_case = test_case
        end

        def call
          super do
            chain { wrap_test_case }
            chain { create_test_case }
            chain { init_current_test_case }
          end
        end

        private

        attr_accessor :client, :test_case, :wrapped_test_case, :test_case_id

        def wrap_test_case
          self.wrapped_test_case = Handlers::TestCaseHandler.new(
            client.zafira_test_case_handler_class,
            client.test_case_handler_class, test_case
          )

          client.current_test_case =
            Models::TestCase::Builder.new(client, wrapped_test_case).construct
        end

        def create_test_case
          test_case_response =
            Api::TestCase::Create.new(client, wrapped_test_case).create

          if test_case_response.code == 200
            self.test_case_id = test_case_response.parsed_response['id']
            return
          end

          dam("TestCase's create failed: #{test_case_response.inspect}")
        end

        def init_current_test_case
          # init id
          client.current_test_case.test_case_id = test_case_id
        end
      end
    end
  end
end
