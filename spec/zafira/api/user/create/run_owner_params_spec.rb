# frozen_string_literal: true

describe Zafira::Api::User::Create::RunOwnerParams do
  let(:environment) { build(:environment) }

  let(:params_builder) do
    Zafira::Api::User::Create::RunOwnerParams.new(environment)
  end

  let(:expected_result) do
    {
      username: 'ci_username',
      email: 'ci@zafira.com',
      first_name: 'ci_first_name',
      last_name: 'ci_last_name'
    }
  end

  describe '#construct' do
    it 'returns ci user data' do
      expect(params_builder.construct).to eq(expected_result)
    end
  end
end
