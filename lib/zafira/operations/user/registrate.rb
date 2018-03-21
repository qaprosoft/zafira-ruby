# frozen_string_literal: true

module Zafira
  module Operations
    module User
      class Registrate
        include Concerns::Operationable

        def initialize(client, strategy)
          self.client = client
          self.strategy = strategy
        end

        def call
          super do
            chain { registrate_user }
            chain { init_user }
          end
        end

        private

        attr_accessor :client, :strategy, :user

        def registrate_user
          user_response = Api::User::Create.new(
            client, params_builder.new(client.environment).construct
          ).create

          self.user = Models::User::Builder.new(user_response).construct

          return if user

          dam("User's create failed: #{user_response.inspect}")
        end

        def init_user
          if strategy == Models::User::Type::RUN_OWNER
            init_run_owner
          else
            init_test_suite_owner
          end
        end

        def init_run_owner
          client.run_owner = user
          logger.info("Run Owner ##{user.id} created.")
        end

        def init_test_suite_owner
          client.test_suite_owner = user
          logger.info("TestSuite Owner ##{user.id} created.")
        end

        def params_builder
          if strategy == Models::User::Type::RUN_OWNER
            Api::User::Create::RunOwnerParams
          else
            Api::User::Create::TestSuiteOwnerParams
          end
        end
      end
    end
  end
end
