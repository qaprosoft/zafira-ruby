# frozen_string_literal: true

module Zafira
  module Operations
    module Run
      class Finish
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { finish_run }
          end
        end

        private

        attr_accessor :client

        def finish_run
          run_response = Api::Run::Finish.new(client).finish
          return if run_response.code == 200
          dam("Run's finish failed #{run_response.inspect}")
        end
      end
    end
  end
end
