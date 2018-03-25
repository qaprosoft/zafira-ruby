# frozen_string_literal: true

describe Zafira::Operations::TestCase::Fail do
  let(:client) do
    build(:zafira_client, :with_environment, :with_test_suite,
          :with_test_suite_owner, :with_run, :with_current_test_case, :rspec)
  end

  let(:env) { client.environment }
  let(:example) { build(:example, :finished) }

  let(:failer) { Zafira::Operations::TestCase::Fail.new(client, example) }

  before do
    logger_mock = double('failer.logger').as_null_object
    allow(failer).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'test_case fail failed' do
      describe '#dam' do
        before do
          stub_request(:post, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is unavailable' do
          client.unavailable = true
          failer.call
          expect(failer.dammed?).to eq(true)
          expect(failer.error_pool).to eq('Zafira is unavailable')
        end

        it 'called if zafira is disabled' do
          failer.call
          expect(failer.dammed?).to eq(true)
          expect(failer.error_pool).to eq('Zafira is not enabled')
        end

        it "called if zafira can't fail test_case" do
          expect(client).to receive(:enabled?).and_return(true)
          failer.call
          expect(failer.dammed?).to eq(true)
          expect(failer.error_pool).to match(/TestCase's fail failed/)
        end
      end
    end

    context 'fails test_case and' do
      before do
        stub_request(:post, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: { id: 17 }.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it "doesn't dam" do
        failer.call
        expect(failer.dammed?).to eq(false)
      end
    end
  end
end
