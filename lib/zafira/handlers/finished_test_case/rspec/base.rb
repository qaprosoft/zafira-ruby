# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Rspec
        class Base
          def initialize(current_test_case, example)
            self.example = example
            self.current_test_case = current_test_case
          end

          def status
            raise NotImplementedError
          end

          def start_time
            example.metadata[:execution_result].started_at.to_i
          end

          def end_time
            example.metadata[:execution_result].finished_at.to_i
          end

          def message
            raise NotImplementedError
          end

          private

          attr_accessor :example, :current_test_case
        end
      end
    end
  end
end
