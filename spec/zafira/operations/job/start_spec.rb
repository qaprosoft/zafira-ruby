# frozen_string_literal: true

describe Zafira::Operations::Job::Start do
  let(:client) { build(:zafira_client, :with_environment, :with_run_owner) }
  let(:env) { client.environment }

  let(:starter) { Zafira::Operations::Job::Start.new(client) }

  before do
    logger_mock = double('starter.logger').as_null_object
    allow(starter).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'job start failed' do
      describe '#dam' do
        before do
          stub_request(:post, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is unavailable' do
          client.unavailable = true
          starter.call
          expect(starter.dammed?).to eq(true)
          expect(starter.error_pool).to eq('Zafira is unavailable')
        end

        it 'called if zafira is disabled' do
          starter.call
          expect(starter.dammed?).to eq(true)
          expect(starter.error_pool).to eq('Zafira is not enabled')
        end

        it "called if zafira can't start job" do
          expect(client).to receive(:enabled?).and_return(true)
          starter.call
          expect(starter.dammed?).to eq(true)
          expect(starter.error_pool).to match(/Job's start failed/)
        end
      end
    end

    context 'starts job and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: { id: 17 }.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it 'initializes job' do
        starter.call
        expect(client.job).not_to eq(nil)
        expect(client.job.class).to eq(Zafira::Models::Job)
      end
    end
  end
end
