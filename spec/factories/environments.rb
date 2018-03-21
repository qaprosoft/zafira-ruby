# frozen_string_literal: true

FactoryBot.define do
  factory :environment, class: Zafira::Models::Environment do
    zafira_api_url 'http://localhost'

    ci_username 'ci_username'
    ci_user_email 'ci@zafira.com'
    ci_user_first_name 'ci_first_name'
    ci_user_last_name 'ci_last_name'

    test_suite_username 'test_suite_username'
    test_suite_email 'test_suite@zafira.com'
    test_suite_first_name 'test_suite_first_name'
    test_suite_last_name 'test_suite_last_name'

    trait :with_optional_data do
      env 'env'
      platform 'platform'
      browser 'browser'
      browser_version 'browser_version'
      app_version 'app_version'
    end
  end
end
