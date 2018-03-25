# frozen_string_literal: true

describe Zafira::Api::Run::Start do
  let(:client) do
    build(:zafira_client, :with_environment,
          :with_job, :with_test_suite, :with_run_owner, :rspec)
  end

  let(:environment) { client.environment }

  let(:run) do
    Zafira::Api::Run::Start.new(
      client,
      Zafira::Models::Run::Initiator::HUMAN,
      Zafira::Models::Run::DriverMode::SUITE_MODE
    )
  end

  describe '#start' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'starts run' do
      expect(run.start.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(run).to receive(:request_params).and_call_original
      expect(run).to receive(:headers).and_call_original
      expect(run).to receive(:body).and_call_original
      expect(run).to receive(:endpoint).and_call_original
      expect(run).to receive(:client_params).and_call_original
      expect(run).to receive(:environment_params).and_call_original

      expect(environment).to receive(:ci_test_run_uuid)
      expect(environment).to receive(:ci_run_build_number)
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)

      run.start
    end

    it 'returns started run json' do
      expect(JSON.parse(run.start.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(run).to receive(:retryable)
        run.start
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it do
      expect(Zafira::Api::Run::Start::RUN_START_ENDPOINT).to(
        eq('/api/tests/runs')
      )
    end
  end
end
