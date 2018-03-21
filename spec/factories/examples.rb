# frozen_string_literal: true

FactoryBot.define do
  factory :example, class: OpenStruct do
    trait :finished do
      metadata(execution_result: OpenStruct.new)
      exception(OpenStruct.new(backtrace: %w[error1 error2]))
    end

    trait :new do
      metadata do
        {
          described_class: 'des_class',
          location: 'test_method',
          full_description: 'info'
        }
      end
    end
  end
end
