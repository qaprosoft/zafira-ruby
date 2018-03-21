# frozen_string_literal: true

module Zafira
  module Operations
    module TestCase
      class Start
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { init_start_time }
            chain { start_test_case }
            chain { init_test_id }
          end
        end

        private

        attr_accessor :client, :test_case, :test_id

        def init_start_time
          client.current_test_case.start_time = Time.now
        end

        def start_test_case
          test_case_response = Api::TestCase::Start.new(client).start

          if test_case_response.code == 200
            self.test_id = test_case_response.parsed_response['id']
            return
          end

          dam("TestCase's start failed: #{test_case_response.inspect}")
        end

        def init_test_id
          client.current_test_case.test_id = test_id
        end
      end
    end
  end
end
