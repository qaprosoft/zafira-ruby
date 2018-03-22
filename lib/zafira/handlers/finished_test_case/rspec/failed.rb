# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Rspec
        class Failed < Base
          def message
            output = "#{example.location}\n#{example.exception}"

            if example.exception.backtrace
              output += "\n" + example.exception.backtrace.join("\n")
            end

            output
          end
        end
      end
    end
  end
end
