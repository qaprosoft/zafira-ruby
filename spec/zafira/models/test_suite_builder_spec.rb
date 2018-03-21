# frozen_string_literal: true

describe Zafira::Models::TestSuite::Builder do
  let(:parsed_response) do
    { 'id' => 1, 'name' => 'test_suite_name' }
  end

  let(:response) do
    OpenStruct.new(parsed_response: parsed_response, code: code)
  end

  let(:builder) { Zafira::Models::TestSuite::Builder.new(response) }
  let(:test_suite) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    describe 'test_suite built and' do
      describe '#id' do
        it { expect(test_suite.id).to eq(1) }
      end

      describe '#name' do
        it { expect(test_suite.name).to eq('test_suite_name') }
      end
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'fails to init run' do
      expect(test_suite).to eq(nil)
    end
  end
end
