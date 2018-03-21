# frozen_string_literal: true

describe Zafira::Models::TestCase do
  describe 'CONSTANTS' do
    describe 'Status' do
      let(:constant) { Zafira::Models::TestCase::Status }

      describe 'UNKNOWN' do
        it { expect(constant::UNKNOWN).to eq(0) }
      end

      describe 'IN_PROGRESS' do
        it { expect(constant::IN_PROGRESS).to eq(1) }
      end

      describe 'PASSED' do
        it { expect(constant::PASSED).to eq(2) }
      end

      describe 'FAILED' do
        it { expect(constant::FAILED).to eq(3) }
      end

      describe 'SKIPPED' do
        it { expect(constant::SKIPPED).to eq(4) }
      end

      describe 'ABORTED' do
        it { expect(constant::ABORTED).to eq(5) }
      end
    end
  end
end
