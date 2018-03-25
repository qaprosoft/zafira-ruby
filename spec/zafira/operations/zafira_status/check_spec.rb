# frozen_string_literal: true

describe Zafira::Operations::ZafiraStatus::Check do
  let(:client) do
    build(:zafira_client, :with_environment, :rspec)
  end

  let(:env) { client.environment }

  let(:checker) { Zafira::Operations::ZafiraStatus::Check.new(client) }

  before do
    expect(client).to receive(:enabled?).and_return(true)
    logger_mock = double('checker.logger').as_null_object
    allow(checker).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'refresh token failed' do
      describe '#dam' do
        before do
          stub_request(:get, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is not available' do
          checker.call
          expect(checker.dammed?).to eq(true)
          expect(checker.error_pool).to match(/is not available/)
        end
      end
    end

    context 'respond with 200' do
      before do
        stub_request(:get, /#{env.zafira_api_url}/)
          .and_return(status: 200)
      end

      it 'doesnt dam' do
        checker.call
        expect(checker.dammed?).to eq(false)
      end
    end
  end
end
