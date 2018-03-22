# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Cucumber
        class Skipped < Base
          def message
            ''
          end
        end
      end
    end
  end
end
