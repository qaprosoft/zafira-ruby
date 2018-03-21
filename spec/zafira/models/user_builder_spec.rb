# frozen_string_literal: true

describe Zafira::Models::User::Builder do
  let(:parsed_response) do
    { 'id' => 1, 'username' => 'username' }
  end

  let(:response) do
    OpenStruct.new(parsed_response: parsed_response, code: code)
  end

  let(:builder) { Zafira::Models::User::Builder.new(response) }
  let(:user) { builder.construct }

  context 'zafira responses with 200 status' do
    let(:code) { 200 }

    describe 'user built and' do
      describe '#id' do
        it { expect(user.id).to eq(1) }
      end

      describe '#username' do
        it { expect(user.username).to eq('username') }
      end
    end
  end

  context 'zafira responses with not 200 status' do
    let(:code) { 400 }

    it 'fails to init run' do
      expect(user).to eq(nil)
    end
  end
end
