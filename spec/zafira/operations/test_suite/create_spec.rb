# frozen_string_literal: true

describe Zafira::Operations::TestSuite::Create do
  let(:client) do
    build(:zafira_client, :with_environment, :with_test_suite_owner)
  end

  let(:env) { client.environment }

  let(:creator) { Zafira::Operations::TestSuite::Create.new(client) }

  before do
    logger_mock = double('creator.logger').as_null_object
    allow(creator).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'test_suite create failed' do
      describe '#dam' do
        before do
          stub_request(:post, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is unavailable' do
          client.unavailable = true
          creator.call
          expect(creator.dammed?).to eq(true)
          expect(creator.error_pool).to eq('Zafira is unavailable')
        end

        it 'called if zafira is disabled' do
          creator.call
          expect(creator.dammed?).to eq(true)
          expect(creator.error_pool).to eq('Zafira is not enabled')
        end

        it "called if zafira can't create test_suite" do
          expect(client).to receive(:enabled?).and_return(true)
          creator.call
          expect(creator.dammed?).to eq(true)
          expect(creator.error_pool).to match(/TestSuite's create failed/)
        end
      end
    end

    context 'creates test_suite and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: { id: 17 }.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it 'initializes test_suite' do
        creator.call
        expect(client.test_suite).not_to eq(nil)
        expect(client.test_suite.class).to eq(Zafira::Models::TestSuite)
      end
    end
  end
end
