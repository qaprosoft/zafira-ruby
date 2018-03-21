# frozen_string_literal: true

module Zafira
  module Models
    class Environment
      MANDATORY_PARAMS = %w[
        zafira_api_url zafira_access_token zafira_project_name
        test_suite_config_file test_suite_name ci_job_name
        ci_job_url ci_host ci_test_run_uuid ci_run_build_number
        zafira_enabled
      ].freeze

      CI_USER_PARAMS = %w[
        ci_username ci_user_email ci_user_first_name ci_user_last_name
      ].freeze

      TEST_SUITE_PARAMS = %w[test_suite_description].freeze

      TEST_SUITE_USER_PARAMS = %w[
        test_suite_username test_suite_email
        test_suite_first_name test_suite_last_name
      ].freeze

      OPTIONAL_PARAMS = %w[
        env platform browser browser_version app_version refresh_token
      ].freeze

      ALL_PARAMS = (
        MANDATORY_PARAMS + TEST_SUITE_PARAMS + TEST_SUITE_USER_PARAMS +
        CI_USER_PARAMS + OPTIONAL_PARAMS
      ).freeze

      attr_accessor(*ALL_PARAMS)

      class Builder
        def initialize(yaml_data)
          self.yaml_data = yaml_data
        end

        def construct
          environment = Environment.new
          ALL_PARAMS.each do |param|
            environment.public_send("#{param}=", yaml_data[param])
          end

          environment
        end

        private

        attr_accessor :yaml_data
      end
    end
  end
end
