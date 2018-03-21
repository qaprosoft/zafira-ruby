# frozen_string_literal: true

describe Zafira::Rspec::Formatter do
  let(:formatter) { Zafira::Rspec::Formatter.new(nil) }

  before do
    allow_any_instance_of(Logger).to receive(:info).and_return(nil)
    allow_any_instance_of(Logger).to receive(:error).and_return(nil)
  end

  before do
    allow_any_instance_of(Zafira::Operations::Environment::Load).to(
      receive(:file_path).and_return('./spec/fixtures/base_env.yml')
    )
  end

  describe '#initialize' do
    describe 'calls #init' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:init).and_return(nil)
        )
        formatter
      end
    end

    describe 'loads env' do
      it do
        expect_any_instance_of(Zafira::Operations::Environment::Load).to(
          receive(:call).and_call_original
        )
        formatter
      end
    end

    describe 'checks status' do
      it do
        expect_any_instance_of(Zafira::Operations::ZafiraStatus::Check).to(
          receive(:call).and_call_original
        )
        formatter
      end
    end
  end

  describe '#start' do
    describe 'calls #start' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:start).and_return(nil)
        )
        formatter.start(nil)
      end
    end

    describe 'starts run' do
      it do
        expect_any_instance_of(Zafira::Operations::Run::Start).to receive(:call)
        formatter.start(nil)
      end
    end
  end

  describe '#example_started' do
    describe 'calls #create_test_case' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:create_test_case).and_return(nil)
        )
        formatter.create_test_case(build(:example))
      end
    end

    describe 'creates test_case' do
      it do
        expect_any_instance_of(Zafira::Operations::TestCase::Create).to(
          receive(:call)
        )
        formatter.create_test_case(build(:example))
      end
    end
  end

  describe '#example_passed' do
    describe 'calls #pass_test_case' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:pass_test_case).and_return(nil)
        )
        formatter.pass_test_case(build(:example))
      end
    end

    describe 'passes test_case' do
      it do
        expect_any_instance_of(Zafira::Operations::TestCase::Pass).to(
          receive(:call)
        )
        formatter.pass_test_case(build(:example))
      end
    end
  end

  describe '#example_failed' do
    describe 'calls #fail_test_case' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:fail_test_case).and_return(nil)
        )
        formatter.example_failed(build(:example))
      end
    end

    describe 'fails test_case' do
      it do
        expect_any_instance_of(Zafira::Operations::TestCase::Fail).to(
          receive(:call)
        )
        formatter.example_failed(build(:example))
      end
    end
  end

  describe '#example_skipped' do
    describe 'calls #skip_test_case' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:skip_test_case).and_return(nil)
        )
        formatter.example_pending(build(:example))
      end
    end

    describe 'skips test_case' do
      it do
        expect_any_instance_of(Zafira::Operations::TestCase::Skip).to(
          receive(:call)
        )
        formatter.example_pending(build(:example))
      end
    end
  end

  describe '#stop' do
    describe 'calls #skip_test_case' do
      it do
        allow_any_instance_of(Zafira::Rspec::Formatter).to(
          receive(:stop_run).and_return(nil)
        )
        formatter.stop(nil)
      end
    end

    describe 'stops run' do
      it do
        expect_any_instance_of(Zafira::Operations::Run::Finish).to(
          receive(:call)
        )
        formatter.stop(nil)
      end
    end
  end
end
