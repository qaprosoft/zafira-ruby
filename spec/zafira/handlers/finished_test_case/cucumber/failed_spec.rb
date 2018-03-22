# frozen_string_literal: true

describe Zafira::Handlers::FinishedTestCase::Cucumber::Failed do
  let(:client) { build(:zafira_client, :with_current_test_case) }
  let(:example) { build(:example, :finished) }

  let(:wrapped_example) do
    Zafira::Handlers::FinishedTestCase::Cucumber::Failed.new(
      client.current_test_case, example,
      Zafira::Models::TestCase::Status::FAILED
    )
  end

  context 'built object' do
    describe '#status' do
      it { expect(wrapped_example.status).to eq(3) }
    end

    describe '#message' do
      it do
        expect(wrapped_example.message).to(
          eq("error_message\nerror1\nerror2")
        )
      end

      context 'backtrace is nil' do
        before do
          example.exception.backtrace = nil
        end

        it do
          expect(wrapped_example.message).to(
            eq("error_message\nerror1\nerror2")
          )
        end
      end
    end
  end
end
