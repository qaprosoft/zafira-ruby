# frozen_string_literal: true

describe Zafira::Operations::TestCase::Start do
  let(:client) do
    build(:zafira_client, :with_environment, :with_test_suite,
          :with_test_suite_owner, :with_run, :with_current_test_case, :rspec)
  end

  let(:env) { client.environment }

  let(:starter) { Zafira::Operations::TestCase::Start.new(client) }

  before do
    logger_mock = double('starter.logger').as_null_object
    allow(starter).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'test_case start failed' do
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

        it "called if zafira can't start test_case" do
          expect(client).to receive(:enabled?).and_return(true)
          starter.call
          expect(starter.dammed?).to eq(true)
          expect(starter.error_pool).to match(/TestCase's start failed/)
        end
      end
    end

    context 'starts test_case and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: { id: 17 }.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it "doesn't dam" do
        starter.call
        expect(starter.dammed?).to eq(false)
      end
    end
  end
end
