# frozen_string_literal: true

module Zafira
  module Handlers
    module FinishedTestCase
      module Rspec
        class Passed < Base
          def status
            Models::TestCase::Status::PASSED
          end

          def message
            ''
          end
        end
      end
    end
  end
end
