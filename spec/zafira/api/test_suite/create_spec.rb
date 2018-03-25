# frozen_string_literal: true

describe Zafira::Api::TestSuite::Create do
  let(:client) do
    build(:zafira_client, :with_environment, :with_test_suite_owner, :rspec)
  end

  let(:environment) { client.environment }
  let(:test_suite) { Zafira::Api::TestSuite::Create.new(client) }

  describe '#create' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'starts test_suite' do
      expect(test_suite.create.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:test_suite_name)
      expect(environment).to receive(:test_suite_config_file)
      expect(environment).to receive(:test_suite_description)
      expect(environment).to receive(:zafira_access_token)

      expect(client.test_suite_owner).to receive(:id).and_call_original

      test_suite.create
    end

    it 'returns created test_suite json' do
      expect(JSON.parse(test_suite.create.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(test_suite).to receive(:retryable)
        test_suite.create
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::TestSuite::Create::CREATE_ENDPOINT).to(
        eq('/api/tests/suites')
      )
    end
  end
end
