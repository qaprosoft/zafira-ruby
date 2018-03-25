# frozen_string_literal: true

describe Zafira::Operations::Run::Finish do
  let(:client) { build(:zafira_client, :with_environment, :with_run, :rspec) }
  let(:env) { client.environment }

  let(:finisher) { Zafira::Operations::Run::Finish.new(client) }

  before do
    logger_mock = double('starter.logger').as_null_object
    allow(finisher).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'run finish failed' do
      describe '#dam' do
        before do
          stub_request(:post, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is unavailable' do
          client.unavailable = true
          finisher.call
          expect(finisher.dammed?).to eq(true)
          expect(finisher.error_pool).to eq('Zafira is unavailable')
        end

        it 'called if zafira is disabled' do
          finisher.call
          expect(finisher.dammed?).to eq(true)
          expect(finisher.error_pool).to eq('Zafira is not enabled')
        end

        it "called if zafira can't finish run" do
          expect(client).to receive(:enabled?).and_return(true)
          finisher.call
          expect(finisher.dammed?).to eq(true)
          expect(finisher.error_pool).to match(/Run's finish failed/)
        end
      end
    end

    context 'run finished and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200)

        expect(client).to receive(:enabled?).and_return(true)
      end

      describe '#dammed?' do
        it do
          finisher.call
          expect(finisher.dammed?).to eq(false)
        end
      end
    end
  end
end
