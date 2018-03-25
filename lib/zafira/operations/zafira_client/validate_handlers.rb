# frozen_string_literal: true

module Zafira
  module Operations
    module ZafiraClient
      class ValidateHandlers
        include Concerns::Operationable

        TEST_CASE_HANDLER_METHODS = %i[test_class test_method info].freeze
        FINISHED_TEST_CASE_HANDLER_METHODS = %i[status message
                                                start_time end_time].freeze

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { validate_test_case_handler_class }
            chain { validate_failed_test_case_handler_class }
            chain { validate_passed_test_case_handler_class }
            chain { validate_skipped_test_case_handler_class }
          end
        end

        private

        attr_accessor :client

        def validate_test_case_handler_class
          handler_class = client.test_case_handler_class
          dam_nil_handler('test_case_handler_class', handler_class)

          chain do
            dam_not_implemented_methods(
              'test_case_handler_class',
              TEST_CASE_HANDLER_METHODS - handler_class.instance_methods
            )
          end
        end

        def validate_failed_test_case_handler_class
          validate_finished_test_handler(
            'failed_test_case_handler_class',
            client.failed_test_case_handler_class
          )
        end

        def validate_passed_test_case_handler_class
          validate_finished_test_handler(
            'passed_test_case_handler_class',
            client.passed_test_case_handler_class
          )
        end

        def validate_skipped_test_case_handler_class
          validate_finished_test_handler(
            'skipped_test_case_handler_class',
            client.skipped_test_case_handler_class
          )
        end

        def validate_finished_test_handler(handler_name, handler_class)
          dam_nil_handler(handler_name, handler_class)

          chain do
            dam_not_implemented_methods(
              handler_name,
              FINISHED_TEST_CASE_HANDLER_METHODS -
                handler_class.instance_methods
            )
          end
        end

        def dam_nil_handler(name, handler)
          dam("`#{name}` must be set in your config file") unless handler
        end

        def dam_not_implemented_methods(name, not_imeplemented_methods)
          return if not_imeplemented_methods.empty?
          dam(
            "`#{name}` - method(s) #{not_imeplemented_methods} must be " \
            'implemented in handler class'
          )
        end
      end
    end
  end
end
