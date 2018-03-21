# frozen_string_literal: true

describe Zafira::Api::Job::Start do
  let(:client) { build(:zafira_client, :with_environment, :with_run_owner) }
  let(:environment) { client.environment }
  let(:job) { Zafira::Api::Job::Start.new(client) }

  describe '#start' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'starts job' do
      expect(job.start.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(job).to receive(:request_params).and_call_original
      expect(job).to receive(:endpoint).and_call_original
      expect(job).to receive(:headers).and_call_original
      expect(job).to receive(:body).and_call_original

      expect(client.run_owner).to receive(:id)

      expect(environment).to receive(:ci_job_name)
      expect(environment).to receive(:ci_job_url)
      expect(environment).to receive(:ci_host)
      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)

      job.start
    end

    it 'returns started job json' do
      expect(JSON.parse(job.start.body)).to eq('id' => 1)
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(job).to receive(:retryable)
        job.start
      end
    end
  end

  describe '#CREATE_ENDPOINT' do
    it { expect(Zafira::Api::Job::Start::START_ENDPOINT).to eq('/api/jobs') }
  end
end
