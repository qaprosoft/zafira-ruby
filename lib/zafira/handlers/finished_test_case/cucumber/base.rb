# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Cucumber
        class Base
          def initialize(current_test_case, scenario)
            self.scenario = scenario
            self.current_test_case = current_test_case
          end

          def status
            raise NotImplementedError
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

          attr_accessor :scenario, :current_test_case
        end
      end
    end
  end
end
