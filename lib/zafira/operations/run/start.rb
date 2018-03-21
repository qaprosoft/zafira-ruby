# frozen_string_literal: true

module Zafira
  module Operations
    module Run
      class Start
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { create_run }
            chain { init_run }
          end
        end

        private

        attr_accessor :client, :run

        def create_run
          run_response = send_request

          self.run = Models::Run::Builder.new(run_response).construct
          return if run

          dam("Run's create failed: #{run_response.inspect}")
        end

        def init_run
          client.run = run
          logger.info("Run ##{run.id} started.")
        end

        def send_request
          Api::Run::Start.new(
            client,
            Models::Run::Initiator::HUMAN,
            Models::Run::DriverMode::SUITE_MODE
          ).start
        end
      end
    end
  end
end
