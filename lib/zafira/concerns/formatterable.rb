# frozen_string_literal: true

module Zafira
  module Concerns
    module Formatterable
      def init(configuration)
        self.zafira_client = Zafira::Client.new(configuration)
        Operations::Environment::Load.new(zafira_client).call
        Operations::ZafiraStatus::Check.new(zafira_client).call
        Operations::ZafiraClient::ValidateHandlers.new(zafira_client).call
      end

      def start_run
        # register user who initiated test run
        Operations::User::Registrate.new(
          zafira_client, Models::User::Type::RUN_OWNER
        ).call

        # register test suite along with suite owner
        Operations::User::Registrate.new(
          zafira_client, Models::User::Type::TEST_SUITE_OWNER
        ).call

        # create test suite, job, start
        Operations::TestSuite::Create.new(zafira_client).call
        Operations::Job::Start.new(zafira_client).call
        Operations::Run::Start.new(zafira_client).call
      end

      def create_test_case(test_case)
        Operations::TestCase::Create.new(zafira_client, test_case).call
        Operations::TestCase::Start.new(zafira_client).call
      end

      def pass_test_case(test_case)
        Operations::TestCase::Pass.new(zafira_client, test_case).call
      end

      def fail_test_case(test_case)
        Operations::TestCase::Fail.new(zafira_client, test_case).call
      end

      def skip_test_case(test_case)
        Operations::TestCase::Skip.new(zafira_client, test_case).call
      end

      def stop_run
        Operations::Run::Finish.new(zafira_client).call
      end

      private

      attr_accessor :zafira_client
    end
  end
end
