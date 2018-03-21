# frozen_string_literal: true

module Zafira
  module Models
    Job = Struct.new(:id, :name, :job_url, :ci_host)

    class Job
      class Builder
        def initialize(response)
          self.json = response.parsed_response
          self.code = response.code
        end

        def construct
          return nil if code != 200

          job = Job.new
          job.id = json['id']
          job.name = json['id']
          job.job_url = json['jobURL']
          job.ci_host = json['jenkinsHost']
          job
        end

        private

        attr_accessor :json, :code
      end
    end
  end
end
