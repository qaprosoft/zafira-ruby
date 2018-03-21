# frozen_string_literal: true

module Zafira
  module Operations
    module Environment
      class Load
        include Concerns::Operationable

        ENV_ZAFIRA_PREFIX = 'ZAFIRA_ENV_'

        def initialize(client)
          self.client = client
        end

        def call
          super do
            chain { validate_file_path }
            chain { load_file }
            chain { load_env_variables }
            chain { validate_required_params }
            chain { validate_whitelisted_params }
            chain { init_environment }
          end
        end

        private

        attr_accessor :client, :yaml_data

        def validate_file_path
          dam("#{file_path_env_name} is required") unless file_path

          chain do
            return if File.exist?(file_path)
            dam("#{file_path_env_name} is not exist")
          end
        end

        def load_file
          self.yaml_data = YAML.load_file(file_path)
        rescue
          dam("#{file_path_env_name} is invalid yml file")
        end

        def load_env_variables
          # iterate all possible and try to load them from env
          Models::Environment::ALL_PARAMS.each do |param|
            if ENV[ENV_ZAFIRA_PREFIX + param.upcase]
              yaml_data[param.downcase] = ENV[ENV_ZAFIRA_PREFIX + param.upcase]
            end
          end
        end

        def validate_required_params
          required_params =
            Models::Environment::MANDATORY_PARAMS - yaml_data.keys

          return if required_params.empty?

          dam("PARAMS [#{required_params.join(',')}] are required")
        end

        def validate_whitelisted_params
          not_allowed_params = yaml_data.keys - Models::Environment::ALL_PARAMS

          return if not_allowed_params.empty?

          dam("PARAMS [#{not_allowed_params.join(',')}] are not allowed")
        end

        def init_environment
          client.environment =
            Models::Environment::Builder.new(yaml_data).construct

          logger.info('ZAFIRA ENVIRONMENT PARAMS are loaded.')

          dam('ZAFIRA is not enabled.') if client.disabled?
        end

        def file_path
          ENV["#{ENV_ZAFIRA_PREFIX}TEST_SUITE_CONFIG_FILE"] || ''
        end

        def file_path_env_name
          "ENV[#{ENV_ZAFIRA_PREFIX}TEST_SUITE_CONFIG_FILE]"
        end
      end
    end
  end
end
