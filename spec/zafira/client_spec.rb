# frozen_string_literal: true

describe Zafira::Client do
  describe '#disabled?' do
    context 'when zafira is not enabled' do
      let(:env) { build(:environment, zafira_enabled: false) }

      it do
        expect(build(:zafira_client, environment: env).disabled?).to eq(true)
      end
    end
  end

  describe '#enabled?' do
    context 'when environment is loaded and zafira enabled' do
      let(:env) { build(:environment, zafira_enabled: true) }

      it do
        expect(build(:zafira_client, environment: env).enabled?).to eq(true)
      end
    end

    context 'when environment is not loaded' do
      it { expect(build(:zafira_client).enabled?).to eq(true) }
    end
  end
end
