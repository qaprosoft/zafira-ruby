# frozen_string_literal: true

describe Zafira::Models::User do
  describe 'CONSTANTS' do
    describe 'Type' do
      let(:constant) { Zafira::Models::User::Type }

      describe 'RUN_OWNER' do
        it { expect(constant::RUN_OWNER).to eq(:run_owner) }
      end

      describe 'TEST_SUITE_OWNER' do
        it { expect(constant::TEST_SUITE_OWNER).to eq(:test_suite_owner) }
      end
    end
  end
end
