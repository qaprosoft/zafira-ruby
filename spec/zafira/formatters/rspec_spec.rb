# frozen_string_literal: true

describe Zafira::Rspec::Formatter do
  let(:framework_config) do
    build(:framework_config, :rspec)
  end

  let(:formatter) { Zafira::Rspec::Formatter.new(framework_config) }

  describe '#start_run' do
    before do
      allow_any_instance_of(
        Zafira::Operations::User::Registrate
      ).to receive(:call)

      expect_any_instance_of(
        Zafira::Operations::TestSuite::Create
      ).to receive(:call)

      expect_any_instance_of(Zafira::Operations::Job::Start).to receive(:call)
      expect_any_instance_of(Zafira::Operations::Run::Start).to receive(:call)
    end

    it 'creates run and test suite owners' do
      formatter.start_run
    end

    it 'creates test suite' do
      formatter.start_run
    end

    it 'starts job' do
      formatter.start_run
    end

    it 'starts run' do
      formatter.start_run
    end
  end

  describe '#create_test_case' do
    before do
      expect_any_instance_of(
        Zafira::Operations::TestCase::Create
      ).to receive(:call)

      expect_any_instance_of(
        Zafira::Operations::TestCase::Start
      ).to receive(:call)
    end

    it 'creates and starts test case' do
      formatter.create_test_case(nil)
    end
  end

  describe '#pass_test_case' do
    before do
      expect_any_instance_of(
        Zafira::Operations::TestCase::Pass
      ).to receive(:call)
    end

    it 'passes test case' do
      formatter.pass_test_case(nil)
    end
  end

  describe '#fail_test_case' do
    before do
      expect_any_instance_of(
        Zafira::Operations::TestCase::Fail
      ).to receive(:call)
    end

    it 'fails test case' do
      formatter.fail_test_case(nil)
    end
  end

  describe '#skip_test_case' do
    before do
      expect_any_instance_of(
        Zafira::Operations::TestCase::Skip
      ).to receive(:call)
    end

    it 'fails test case' do
      formatter.skip_test_case(nil)
    end
  end

  describe '#stop_run' do
    before do
      expect_any_instance_of(
        Zafira::Operations::Run::Finish
      ).to receive(:call)
    end

    it 'stops' do
      formatter.stop_run
    end
  end
end
