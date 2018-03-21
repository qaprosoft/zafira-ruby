# frozen_string_literal: true

describe Zafira::Operations::User::RefreshToken do
  let(:client) do
    build(:zafira_client, :with_environment)
  end

  let(:env) { client.environment }

  let(:refresher) { Zafira::Operations::User::RefreshToken.new(client) }

  before do
    logger_mock = double('refresher.logger').as_null_object
    allow(refresher).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'refresh token failed' do
      describe '#dam' do
        before do
          stub_request(:post, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it "called if zafira can't refresh token" do
          refresher.call
          expect(refresher.dammed?).to eq(true)
          expect(refresher.error_pool).to match(/Token's refresh failed/)
        end
      end
    end

    context 'refresh token and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: ''.to_json)
      end

      it 'updates it in client' do
        refresher.call
        expect(refresher.dammed?).to eq(false)
      end
    end
  end
end
