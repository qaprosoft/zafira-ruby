# frozen_string_literal: true

describe Zafira::Api::User::RefreshToken do
  let(:client) { build(:zafira_client, :with_environment, :rspec) }
  let(:environment) { client.environment }

  let(:token) { Zafira::Api::User::RefreshToken.new(client) }

  describe '#refresh' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { token: 1 }.to_json)
    end

    it 'refreshes token' do
      expect(token.refresh.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:refresh_token)

      token.refresh
    end

    it 'returns refreshed token json' do
      expect(JSON.parse(token.refresh.body)).to eq('token' => 1)
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::User::RefreshToken::REFRESH_TOKEN_ENDPOINT).to(
        eq('/api/auth/refresh')
      )
    end
  end
end
