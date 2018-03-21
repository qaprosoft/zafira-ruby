# frozen_string_literal: true

describe Zafira::Models::Run do
  describe 'CONSTANTS' do
    describe 'Initiator' do
      let(:constant) { Zafira::Models::Run::Initiator }

      describe 'SCHEDULER' do
        it { expect(constant::SCHEDULER).to eq(0) }
      end

      describe 'UPSTREAM_JOB' do
        it { expect(constant::UPSTREAM_JOB).to eq(1) }
      end

      describe 'HUMAN' do
        it { expect(constant::HUMAN).to eq(2) }
      end
    end

    describe 'DriverMode' do
      let(:constant) { Zafira::Models::Run::DriverMode }

      describe 'METHOD_MODE' do
        it { expect(constant::METHOD_MODE).to eq(0) }
      end

      describe 'CLASS_MODE' do
        it { expect(constant::CLASS_MODE).to eq(1) }
      end

      describe 'SUITE_MODE' do
        it { expect(constant::SUITE_MODE).to eq(2) }
      end
    end
  end
end
