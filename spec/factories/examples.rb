# frozen_string_literal: true

FactoryBot.define do
  factory :example, class: OpenStruct do
    trait :finished do
      metadata(execution_result: OpenStruct.new)
      exception(OpenStruct.new(backtrace: %w[error1 error2]))
      result(OpenStruct.new(
               exception: OpenStruct.new(
                 message: 'error_message', backtrace: %w[error1 error2]
               )
      ))
    end

    trait :new do
      source(OpenStruct.new(first: OpenStruct.new(name: 'des_class')))
      name 'info'
      location 'test_method'

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
