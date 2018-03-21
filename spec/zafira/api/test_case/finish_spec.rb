# frozen_string_literal: true

describe Zafira::Api::TestCase::Finish do
  let(:client) do
    build(:zafira_client, :with_environment, :with_run, :with_current_test_case)
  end

  let(:environment) { client.environment }
  let(:current_test_case) { client.current_test_case }
  let(:test_case_result) { build(:example, :finished) }

  let(:finisher) do
    Zafira::Api::TestCase::Finish.new(
      client,
      Zafira::Handlers::FinishedTestCase::Rspec::Passed.new(
        client.current_test_case, test_case_result
      )
    )
  end

  describe '#finish' do
    before do
      stub_request(:post, /#{environment.zafira_api_url}/)
        .and_return(status: 200, body: { id: 1 }.to_json)
    end

    it 'finishes test_case' do
      expect(finisher.finish.code).to eq(200)
    end

    it 'sends request to zafira' do
      expect(client.run).to receive(:id)

      expect(environment).to receive(:zafira_api_url).and_call_original
      expect(environment).to receive(:zafira_access_token)

      expect(current_test_case).to receive(:test_case_id)
      expect(current_test_case).to receive(:info)

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
