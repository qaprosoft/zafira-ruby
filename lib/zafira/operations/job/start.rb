# frozen_string_literal: true

module Zafira
  module Operations
    module Job
      class Start
        include Concerns::Operationable

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { start_job }
            chain { init_job }
          end
        end

        private

        attr_accessor :client, :job

        def start_job
          job_response = Api::Job::Start.new(client).start
          self.job = Models::Job::Builder.new(job_response).construct

          return if job

          dam("Job's start failed: `#{job_response.inspect}`")
        end

        def init_job
          client.job = job
          logger.info("Job ##{job.id} started")
        end
      end
    end
  end
end
