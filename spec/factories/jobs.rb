# frozen_string_literal: true

FactoryBot.define do
  factory :job, class: Zafira::Models::Job do
    sequence(:id) { |number| number }
  end
end
