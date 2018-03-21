# frozen_string_literal: true

describe Zafira::Operations::User::Registrate do
  let(:client) do
    build(:zafira_client, :with_environment)
  end

  let(:env) { client.environment }

  let(:run_owner_creator) do
    Zafira::Operations::User::Registrate.new(
      client, Zafira::Models::User::Type::RUN_OWNER
    )
  end

  let(:test_suite_owner_creator) do
    Zafira::Operations::User::Registrate.new(
      client, Zafira::Models::User::Type::TEST_SUITE_OWNER
    )
  end

  before do
    logger_mock = double('run_owner_creator.logger').as_null_object
    allow(run_owner_creator).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'user create failed' do
      describe '#dam' do
        before do
          stub_request(:put, /#{env.zafira_api_url}/)
            .and_return(status: 400)
        end

        it 'called if zafira is unavailable' do
          client.unavailable = true
          run_owner_creator.call
          expect(run_owner_creator.dammed?).to eq(true)
          expect(run_owner_creator.error_pool).to eq('Zafira is unavailable')
        end

        it 'called if zafira is disabled' do
          run_owner_creator.call
          expect(run_owner_creator.dammed?).to eq(true)
          expect(run_owner_creator.error_pool).to eq('Zafira is not enabled')
        end

        it "called if zafira can't create user" do
          expect(client).to receive(:enabled?).and_return(true)
          run_owner_creator.call
          expect(run_owner_creator.dammed?).to eq(true)
          expect(run_owner_creator.error_pool).to match(/User's create failed/)
        end
      end
    end

    context 'creates user and' do
      before do
        stub_request(:put, /#{env.zafira_api_url}/)
          .and_return(status: 200, body: {}.to_json)

        expect(client).to receive(:enabled?).and_return(true)
      end

      it 'initializes run owner' do
        run_owner_creator.call
        expect(client.run_owner).not_to eq(nil)
        expect(client.test_suite_owner).to eq(nil)
        expect(client.run_owner.class).to eq(Zafira::Models::User)
      end

      it 'initializes test_suite owner' do
        logger_mock = double('test_suite_owner_creator.logger').as_null_object
        allow(test_suite_owner_creator).to(
          receive(:logger).and_return(logger_mock)
        )

        test_suite_owner_creator.call
        expect(client.test_suite_owner).not_to eq(nil)
        expect(client.run_owner).to eq(nil)
        expect(client.test_suite_owner.class).to eq(Zafira::Models::User)
      end
    end
  end
end
