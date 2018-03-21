# frozen_string_literal: true

module Zafira
  module Operations
    module TestSuite
      class Create
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { start_test_suite }
            chain { init_test_suite }
          end
        end

        private

        attr_accessor :client, :test_suite

        def start_test_suite
          suite_response = Api::TestSuite::Create.new(client).create

          self.test_suite =
            Models::TestSuite::Builder.new(suite_response).construct

          return if test_suite

          dam("TestSuite's create failed #{suite_response.inspect}")
        end

        def init_test_suite
          client.test_suite = test_suite
          logger.info("TestSuite ##{test_suite.id} created")
        end
      end
    end
  end
end
