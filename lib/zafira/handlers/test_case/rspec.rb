# frozen_string_literal: true

module Zafira
  module Handlers
    module TestCase
      class Rspec
        def initialize(example)
          self.example = example
        end

        def test_class
          example.metadata[:described_class].to_s
        end

        def test_method
          example.metadata[:location]
        end

        def info
          example.metadata[:full_description]
        end

        private

        attr_accessor :example
      end
    end
  end
end
