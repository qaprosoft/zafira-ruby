
# frozen_string_literal: true

describe Zafira::Handlers::FinishedTestCase::Rspec::Failed do
  let(:client) { build(:zafira_client, :with_current_test_case) }
  let(:example) { build(:example, :finished) }
  let(:wrapped_example) do
    Zafira::Handlers::FinishedTestCase::Rspec::Failed.new(
      client.current_test_case, example
    )
  end

  context 'built object' do
    describe '#status' do
      it { expect(wrapped_example.status).to eq(3) }
    end

    describe '#message' do
      before do
        example.location = 'loc.rb:12'
        example.exception.backtrace = %w[error1 error2]

        allow(example.exception).to receive(:to_s).and_return('exception_1')
      end

      it do
        expect(wrapped_example.message).to(
          eq("loc.rb:12\nexception_1\nerror1\nerror2")
        )
      end

      context 'backtrace is nil' do
        before do
          example.exception.backtrace = nil
        end

        it do
          expect(wrapped_example.message).to(
            eq("loc.rb:12\nexception_1")
          )
        end
      end
    end
  end
end
