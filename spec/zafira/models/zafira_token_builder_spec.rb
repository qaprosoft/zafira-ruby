# frozen_string_literal: true

describe Zafira::Models::ZafiraToken::Builder do
  let(:parsed_response) do
    { 'accessToken' => 'access-token', 'refreshToken' => 'refresh-token' }
  end

  let(:response) do
    OpenStruct.new(parsed_response: parsed_response, code: code)
  end

  let(:builder) { Zafira::Models::ZafiraToken::Builder.new(response) }
  let(:token) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    describe 'token refreshed and' do
      describe '#access_token' do
        it { expect(token.access_token).to eq('access-token') }
      end

      describe '#refresh_token' do
        it { expect(token.refresh_token).to eq('refresh-token') }
      end
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'fails to init run' do
      expect(token).to eq(nil)
    end
  end
end
