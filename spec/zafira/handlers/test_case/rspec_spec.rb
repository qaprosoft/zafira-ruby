
# frozen_string_literal: true

describe Zafira::Handlers::TestCase::Rspec do
  let(:example) { build(:example, :new) }
  let(:wrapped_example) { Zafira::Handlers::TestCase::Rspec.new(example) }

  context 'built object' do
    describe '#test_class' do
      it { expect(wrapped_example.test_class).to eq('des_class') }
    end

    describe '#test_method' do
      it { expect(wrapped_example.test_method).to eq('test_method') }
    end

    describe '#info' do
      it { expect(wrapped_example.info).to eq('info') }
    end
  end
end
