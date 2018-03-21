# frozen_string_literal: true

FactoryBot.define do
  factory :run, class: Zafira::Models::Run do
    sequence(:id) { |number| number }
  end
end
