# frozen_string_literal: true

describe Zafira::Api::TestCase::Create do
  let(:client) do
    build(:zafira_client, :with_environment, :with_current_test_case, :rspec)
  end

  let(:environment) { client.environment }
  let(:current_test_case) { client.current_test_case }
  let(:handler) do
    Zafira::Handlers::TestCaseHandler.new(
      client.zafira_test_case_handler_class,
      client.test_case_handler_class, build(:example, :new)
    )
  end

  let(:creator) { Zafira::Api::TestCase::Create.new(client, handler) }

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

      expect(handler).to receive(:test_method)
      expect(handler).to receive(:info)
      expect(handler).to receive(:test_class)

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
