# frozen_string_literal: true

FactoryBot.define do
  factory :zafira_client, class: Zafira::Client do
    trait :with_environment do
      after(:build) do |client|
        client.environment = build(:environment)
      end
    end

    trait :with_run do
      after(:build) do |client|
        client.run = build(:run)
      end
    end

    trait :with_run_owner do
      after(:build) do |client|
        client.run_owner = build(:user)
      end
    end

    trait :with_job do
      after(:build) do |client|
        client.job = build(:job)
      end
    end

    trait :with_test_suite_owner do
      after(:build) do |client|
        client.test_suite_owner = build(:user)
      end
    end

    trait :with_test_suite do
      after(:build) do |client|
        client.test_suite = build(:test_suite)
      end
    end

    trait :with_current_test_case do
      after(:build) do |client|
        client.current_test_case = build(:test_case)
      end
    end

    trait :rspec do
      initialize_with do
        new(build(:framework_config, :rspec))
      end
    end

    trait :cucumber do
      initialize_with do
        new(build(:framework_config, :cucumber))
      end
    end
  end
end
