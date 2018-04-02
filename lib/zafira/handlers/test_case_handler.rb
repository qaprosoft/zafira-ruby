# frozen_string_literal: true

module Zafira
  module Handlers
    class TestCaseHandler
      include Concerns::Handlerable

      def initialize(handler_klass, custom_handler_klass, test_case)
        init_custom_handler(custom_handler_klass, test_case)

        self.handler = handler_klass.new(test_case)
      end

      def test_class
        if custom_handler_respond_to?(:test_class)
          return custom_handler.test_class
        end

        handler.test_class
      end

      def test_method
        if custom_handler_respond_to?(:test_method)
          return custom_handler.test_method
        end

        handler.test_method
      end

      def info
        custom_handler_respond_to?(:info) && (return custom_handler.info)

        handler.info
      end
    end
  end
end
