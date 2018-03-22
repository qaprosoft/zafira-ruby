# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Cucumber
        class Base
          def initialize(current_test_case, event, test_case_status)
            self.current_test_case = current_test_case
            self.scenario = event.test_case
            self.result = event.result
            self.test_case_status = test_case_status
          end

          def status
            test_case_status
          end

          def start_time
            current_test_case.start_time
          end

          def end_time
            current_test_case.end_time
          end

          def message
            raise NotImplementedError
          end

          private

          attr_accessor :current_test_case, :scenario,
                        :result, :test_case_status
        end
      end
    end
  end
end
