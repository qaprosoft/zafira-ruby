# frozen_string_literal: true

describe Zafira::Api::User::Create::RunOwnerParams do
  let(:environment) { build(:environment) }
  let(:params_builder) do
    Zafira::Api::User::Create::TestSuiteOwnerParams.new(environment)
  end

  let(:expected_result) do
    {
      username: 'test_suite_username',
      email: 'test_suite@zafira.com',
      first_name: 'test_suite_first_name',
      last_name: 'test_suite_last_name'
    }
  end

  describe '#construct' do
    it 'returns ci user data' do
      expect(params_builder.construct).to eq(expected_result)
    end
  end
end
