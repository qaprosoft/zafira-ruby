# frozen_string_literal: true

describe Zafira::Api::TestCase::Start do
  let(:client) do
    build(:zafira_client, :with_environment, :with_current_test_case, :rspec)
  end

  let(:environment) { client.environment }
  let(:current_test_case) { client.current_test_case }

  let(:starter) { Zafira::Api::TestCase::Start.new(client) }

  describe '#start' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'starts test_case' do
      expect(starter.start.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(current_test_case).to receive(:test_case_id)
      expect(current_test_case).to receive(:info)
      expect(current_test_case).to receive(:run_id)

      expect(environment).to receive(:zafira_access_token)

      starter.start
    end

    it 'returns started test_case json' do
      expect(JSON.parse(starter.start.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(starter).to receive(:retryable)
        starter.start
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::TestCase::Start::START_ENDPOINT).to eq('/api/tests')
    end
  end
end
