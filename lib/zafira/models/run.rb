# frozen_string_literal: true

module Zafira
  module Models
    Run = Struct.new(:id, :status)

    class Run
      module Initiator
        SCHEDULER = 0
        UPSTREAM_JOB = 1
        HUMAN = 2
      end

      module DriverMode
        METHOD_MODE = 0
        CLASS_MODE = 1
        SUITE_MODE = 2
      end

      class Builder
        def initialize(response)
          self.json = response.parsed_response
          self.response_code = response.code
        end

        def construct
          return nil if response_code != 200

          job = Run.new
          job.id = json['id']
          job.status = json['status']
          job
        end

        private

        attr_accessor :json, :response_code
      end
    end
  end
end
