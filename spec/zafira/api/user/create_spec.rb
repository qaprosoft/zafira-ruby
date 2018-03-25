# frozen_string_literal: true

describe Zafira::Api::User::Create do
  let(:client) { build(:zafira_client, :with_environment, :rspec) }
  let(:environment) { client.environment }

  let(:create_params) do
    Zafira::Api::User::Create::RunOwnerParams.new(environment).construct
  end

  let(:params) do
    Zafira::Api::User::Create::RunOwnerParams.new(environment).construct
  end

  let(:user) { Zafira::Api::User::Create.new(client, create_params) }

  describe '#create' do
    before do
      stub_request(:put, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'creates user' do
      expect(user.create.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)
      user.create
    end

    it 'returns created user json' do
      expect(JSON.parse(user.create.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(user).to receive(:retryable)
        user.create
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::User::Create::CREATE_ENDPOINT).to(
        eq('/api/users')
      )
    end
  end
end
