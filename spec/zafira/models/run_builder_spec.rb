# frozen_string_literal: true

describe Zafira::Models::Run::Builder do
  let(:parsed_response) do
    { 'id' => 1, 'status' => 2 }
  end

  let(:response) do
    OpenStruct.new(parsed_response: parsed_response, code: code)
  end

  let(:builder) { Zafira::Models::Run::Builder.new(response) }
  let(:run) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    describe 'job built and' do
      describe '#id' do
        it { expect(run.id).to eq(1) }
      end

      describe '#status' do
        it { expect(run.status).to eq(2) }
      end
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'fails to init run' do
      expect(run).to eq(nil)
    end
  end
end
