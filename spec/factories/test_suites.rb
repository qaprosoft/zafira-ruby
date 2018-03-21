# frozen_string_literal: true

FactoryBot.define do
  factory :test_suite, class: Zafira::Models::TestSuite do
    sequence(:id) { |number| number }
  end
end
