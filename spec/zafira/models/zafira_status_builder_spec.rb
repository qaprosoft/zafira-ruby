# frozen_string_literal: true

describe Zafira::Models::ZafiraStatus::Builder do
  let(:response) { OpenStruct.new(code: code) }

  let(:builder) { Zafira::Models::ZafiraStatus::Builder.new(response) }
  let(:zafira_status) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    it 'zafira is available' do
      expect(zafira_status.available).to eq(true)
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'zafira is not available' do
      expect(zafira_status).to eq(nil)
    end
  end
end
