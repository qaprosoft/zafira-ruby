# frozen_string_literal: true

describe Zafira::Operations::TestCase::Create do
  let(:client) do
    build(:zafira_client, :with_environment,
          :with_test_suite, :with_test_suite_owner, :with_run, :rspec)
  end

  let(:env) { client.environment }
  let(:example) { build(:example, :new) }

  let(:creator) { Zafira::Operations::TestCase::Create.new(client, example) }

  before do
    logger_mock = double('creator.logger').as_null_object
    allow(creator).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'test_case create failed' do
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

        it "called if zafira can't create test_case" do
          expect(client).to receive(:enabled?).and_return(true)
          creator.call
          expect(creator.dammed?).to eq(true)
          expect(creator.error_pool).to match(/TestCase's create failed/)
        end
      end
    end

    context 'creates test_case and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: { id: 17 }.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it 'initializes test_case' do
        creator.call
        expect(client.current_test_case).not_to eq(nil)
        expect(client.current_test_case.class).to eq(Zafira::Models::TestCase)
      end
    end
  end
end
