# frozen_string_literal: true

FactoryBot.define do
  factory :framework_config, class: OpenStruct do
    trait :rspec do
      zafira_test_case_handler_class Zafira::Handlers::TestCase::Rspec

      zafira_failed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Failed
      end

      zafira_skipped_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Skipped
      end

      zafira_passed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Passed
      end
    end

    trait :cucumber do
      zafira_test_case_handler_class Zafira::Handlers::TestCase::Cucumber

      zafira_failed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Failed
      end

      zafira_skipped_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Skipped
      end

      zafira_passed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Passed
      end
    end
  end
end
