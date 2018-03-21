# frozen_string_literal: true

describe Zafira::Api::Run::Finish do
  let(:client) do
    build(:zafira_client, :with_environment, :with_run_owner, :with_run)
  end

  let(:environment) { client.environment }
  let(:run) { client.run }

  let(:finisher) { Zafira::Api::Run::Finish.new(client) }

  describe '#finish' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200)
    end

    it 'finishs run' do
      expect(finisher.finish.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(finisher).to receive(:request_params).and_call_original
      expect(finisher).to receive(:headers).and_call_original
      expect(finisher).to receive(:endpoint).and_call_original

      expect(run).to receive(:id).and_call_original

      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)

      finisher.finish
    end

    context 'zafira token expired' do
      before do
        stub_request(:post, /#{environment.zafira_api_url}/)
          .and_return(status: 401)
      end

      it 'refreshes token' do
        expect(finisher).to receive(:retryable)
        finisher.finish
      end
    end
  end
end
