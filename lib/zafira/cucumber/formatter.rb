# frozen_string_literal: true

require 'bundler/setup'
require 'zafira/ruby'

module Zafira
  module Cucumber
    class Formatter
      include Concerns::Formatterable

      def initialize(config)
        init(config)
        start_run

        init_test_case_started_event(config)
        init_test_case_finished_event(config)

        init_test_run_finished_event(config)
      end

      private

      def init_test_case_started_event(config)
        config.on_event :test_case_started do |event|
          create_test_case(event.test_case)
        end
      end

      def init_test_case_finished_event(config)
        config.on_event :test_case_finished do |event|
          pass_test_case(event) if event.result.ok?

          fail_test_case(event) if event.result.failed?

          skip_test_case(event) if event.result.skipped?
        end
      end

      def init_test_run_finished_event(config)
        config.on_event :test_run_finished do |_event|
          stop_run
        end
      end
    end
  end
end
