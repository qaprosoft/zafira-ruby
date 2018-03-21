# frozen_string_literal: true

require 'bundler/setup'
require 'zafira/ruby'
require_relative 'spec_helper'

module Zafira
  module Rspec
    class Formatter
      include Concerns::Formatterable

      ::RSpec::Core::Formatters.register(
        self, :start, :example_started, :example_passed,
        :example_failed, :example_pending, :stop
      )

      def initialize(_output)
        init(RSpec.configuration)
      end

      def start(_)
        start_run
      end

      def example_started(output)
        create_test_case(output.example)
      end

      def example_passed(output)
        pass_test_case(output.example)
      end

      def example_failed(output)
        fail_test_case(output.example)
      end

      def example_pending(output)
        skip_test_case(output.example)
      end

      def stop(_)
        stop_run
      end
    end
  end
end
