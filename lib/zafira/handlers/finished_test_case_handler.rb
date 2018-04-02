# frozen_string_literal: true

module Zafira
  module Handlers
    class FinishedTestCaseHandler
      include Concerns::Handlerable

      def initialize(handler_klass, custom_handler_klass, current_test_case,
                     example, test_case_status)

        init_custom_handler(custom_handler_klass, example)

        self.handler =
          handler_klass.new(current_test_case, example, test_case_status)
      end

      def status
        handler.status
      end

      def start_time
        handler.start_time
      end

      def end_time
        handler.end_time
      end

      def artifacts
        if custom_handler_respond_to?(:artifacts)
          return custom_handler.artifacts
        end

        # we dont implement it
        []
      end

      def message
        return custom_handler.message if custom_handler_respond_to?(:info)
        handler.message
      end
    end
  end
end
