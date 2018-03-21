# frozen_string_literal: true

describe Zafira::Models::TestCase::Builder do
  let(:client) do
    build(:zafira_client, :with_test_suite, :with_run, :with_test_suite_owner)
  end

  let(:test_case) do
    OpenStruct.new(
      test_class: 'test_class',
      test_method: 'test_method',
      info: 'info'
    )
  end

  let(:builder) { Zafira::Models::TestCase::Builder.new(client, test_case) }
  let(:wrapped_test_case) { builder.construct }

  before do
    client.test_suite.id = 5
    client.test_suite_owner.id = 6
    client.run.id = 7
  end

  context 'wrapped test_case' do
    let(:code) { 200 }

    describe 'test_case built and' do
      describe '#test_class' do
        it { expect(wrapped_test_case.test_class).to eq('test_class') }
      end

      describe '#test_method' do
        it { expect(wrapped_test_case.test_method).to eq('test_method') }
      end

      describe '#info' do
        it { expect(wrapped_test_case.info).to eq('info') }
      end

      describe '#test_suite_id' do
        it { expect(wrapped_test_case.test_suite_id).to eq(5) }
      end

      describe '#primary_owner_id' do
        it { expect(wrapped_test_case.primary_owner_id).to eq(6) }
      end

      describe '#run_id' do
        it { expect(wrapped_test_case.run_id).to eq(7) }
      end
    end
  end
end
