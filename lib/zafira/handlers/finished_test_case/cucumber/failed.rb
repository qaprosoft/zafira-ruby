# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Cucumber
        class Failed < Base
          def status
            Models::TestCase::Status::FAILED
          end

          def message
            "#{scenario.result.exception.message}\n" \
            "#{scenario.result.exception.backtrace&.join("\n")}"
          end
        end
      end
    end
  end
end
