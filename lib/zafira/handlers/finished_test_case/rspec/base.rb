# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Rspec
        class Base
          def initialize(current_test_case, example, test_case_status)
            self.example = example
            self.current_test_case = current_test_case
            self.test_case_status = test_case_status
          end

          def status
            test_case_status
          end

          def start_time
            example.metadata[:execution_result].started_at.to_i
          end

          def end_time
            example.metadata[:execution_result].finished_at.to_i
          end

          private

          attr_accessor :example, :current_test_case, :test_case_status
        end
      end
    end
  end
end
