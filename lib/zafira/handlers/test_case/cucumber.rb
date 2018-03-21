# frozen_string_literal: true

module Zafira
  module Handlers
    module TestCase
      class Cucumber
        def initialize(scenario)
          self.scenario = scenario
        end

        def test_class
          scenario.source.first.name
        end

        def test_method
          scenario.location.to_s
        end

        def info
          scenario.name
        end

        private

        attr_accessor :scenario
      end
    end
  end
end
