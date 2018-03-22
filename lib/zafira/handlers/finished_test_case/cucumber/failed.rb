# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Cucumber
        class Failed < Base
          def message
            "#{result.exception.message}\n" \
            "#{result.exception.backtrace&.join("\n")}"
          end
        end
      end
    end
  end
end
