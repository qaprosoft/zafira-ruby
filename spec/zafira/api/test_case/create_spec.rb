# frozen_string_literal: true

describe Zafira::Api::TestCase::Create do
  let(:client) do
    build(:zafira_client, :with_environment, :with_current_test_case)
  end

  let(:environment) { client.environment }
  let(:current_test_case) { client.current_test_case }

  let(:creator) { Zafira::Api::TestCase::Create.new(client) }

  describe '#create' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'starts test_case' do
      expect(creator.create.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)

      expect(current_test_case).to receive(:test_class)
      expect(current_test_case).to receive(:test_method)
      expect(current_test_case).to receive(:info)
      expect(current_test_case).to receive(:test_suite_id)
      expect(current_test_case).to receive(:primary_owner_id)

      creator.create
    end

    it 'returns created test_case json' do
      expect(JSON.parse(creator.create.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(creator).to receive(:retryable)
        creator.create
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::TestCase::Create::CREATE_ENDPOINT).to(
        eq('/api/tests/cases')
      )
    end
  end
end
