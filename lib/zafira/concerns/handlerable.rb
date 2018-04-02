# frozen_string_literal: true

# TODO: remove
module Zafira
  module Concerns
    module Handlerable
      private

      def init_custom_handler(handler_klass, test_case)
        self.custom_handler = handler_klass.new(test_case) if handler_klass
      end

      def custom_handler_respond_to?(method_name)
        custom_handler.respond_to?(method_name)
      end

      attr_accessor :handler, :custom_handler
    end
  end
end
