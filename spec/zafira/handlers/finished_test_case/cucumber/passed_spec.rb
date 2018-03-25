# frozen_string_literal: true

describe Zafira::Handlers::FinishedTestCase::Cucumber::Passed do
  let(:client) { build(:zafira_client, :with_current_test_case, :cucumber) }
  let(:example) { build(:example, :finished) }

  let(:wrapped_example) do
    Zafira::Handlers::FinishedTestCase::Cucumber::Passed.new(
      client.current_test_case, example,
      Zafira::Models::TestCase::Status::PASSED
    )
  end

  context 'built object' do
    describe '#status' do
      it { expect(wrapped_example.status).to eq(2) }
    end

    describe '#message' do
      it do
        expect(wrapped_example.message).to eq('')
      end
    end
  end
end
