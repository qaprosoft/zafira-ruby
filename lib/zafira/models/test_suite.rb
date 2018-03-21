# frozen_string_literal: true

module Zafira
  module Models
    TestSuite = Struct.new(:id, :name)

    class TestSuite
      class Builder
        def initialize(response)
          self.json = response.parsed_response
          self.code = response.code
        end

        def construct
          return nil if code != 200

          test_suite = TestSuite.new
          test_suite.id = json['id']
          test_suite.name = json['name']
          test_suite
        end

        private

        attr_accessor :json, :code
      end
    end
  end
end
