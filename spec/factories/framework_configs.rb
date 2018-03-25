# frozen_string_literal: true

FactoryBot.define do
  factory :framework_config, class: OpenStruct do
    trait :rspec do
      test_case_handler_class Zafira::Handlers::TestCase::Rspec

      failed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Failed
      end

      skipped_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Skipped
      end

      passed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Rspec::Passed
      end
    end

    trait :cucumber do
      test_case_handler_class Zafira::Handlers::TestCase::Cucumber

      failed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Failed
      end

      skipped_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Skipped
      end

      passed_test_case_handler_class do
        Zafira::Handlers::FinishedTestCase::Cucumber::Passed
      end
    end
  end
end
