# frozen_string_literal: true

describe Zafira::Api::ZafiraStatus do
  let(:client) { build(:zafira_client, :with_environment) }
  let(:environment) { client.environment }

  let(:token) { Zafira::Api::ZafiraStatus.new(client) }

  describe '#get' do
    before do
      stub_request(:get, /#{environment.zafira_api_url}/)
        .and_return(status: 200)
    end

    it 'returns 200 status' do
      expect(token.get.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      token.get
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::ZafiraStatus::STATUS_ENDPOINT).to(
        eq('/api/status')
      )
    end
  end
end
