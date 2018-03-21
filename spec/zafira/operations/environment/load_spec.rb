# frozen_string_literal: true

describe Zafira::Operations::Environment::Load do
  let(:client) { build(:zafira_client) }
  let(:loader) { Zafira::Operations::Environment::Load.new(client) }

  let(:env) { client.environment }

  before do
    logger_mock = double('loader.logger').as_null_object
    allow(loader).to receive(:logger).and_return(logger_mock)
  end

  describe '#call' do
    context 'load failed' do
      context 'config file is not exist' do
        describe '#error_pool' do
          it do
            allow(loader).to receive(:file_path).and_return('')
            loader.call
            expect(loader.dammed?).to eq(true)
            expect(loader.error_pool).to eq(
              'ENV[ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE] is not exist'
            )
          end

          it do
            allow(loader).to receive(:file_path).and_return(nil)
            loader.call
            expect(loader.dammed?).to eq(true)
            expect(loader.error_pool).to eq(
              'ENV[ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE] is required'
            )
          end
        end
      end

      context 'config file is not yaml file' do
        describe '#error_pool' do
          it do
            allow(loader).to receive(:file_path).and_return('file-path')
            allow(File).to receive(:exist?).and_return(true)
            loader.call
            expect(loader.dammed?).to eq(true)
            expect(loader.error_pool).to eq(
              'ENV[ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE] is invalid yml file'
            )
          end
        end
      end

      context 'some required params are not passed' do
        describe '#error_pool' do
          it do
            allow(loader).to receive(:validate_file_path)
            allow(loader).to receive(:load_file)
            allow(loader).to receive(:load_env_variables)
            allow(loader).to receive(:yaml_data).and_return({})
            loader.call
            expect(loader.dammed?).to eq(true)

            expect(loader.error_pool).to eq(
              'PARAMS [zafira_api_url,zafira_access_token,' \
              'zafira_project_name,test_suite_config_file] are required'
            )
          end
        end
      end

      context 'some params are not allowed' do
        describe '#error_pool' do
          it do
            allow(loader).to receive(:validate_file_path)
            allow(loader).to receive(:load_file)
            allow(loader).to receive(:load_env_variables)
            allow(loader).to receive(:validate_required_params)
            allow(loader).to(
              receive(:yaml_data).and_return('not_allowed_param' => 'test')
            )
            loader.call
            expect(loader.dammed?).to eq(true)
            expect(loader.error_pool).to eq(
              'PARAMS [not_allowed_param] are not allowed'
            )
          end
        end
      end

      context 'zafira is not enabled' do
        before do
          allow(loader).to(
            receive(:file_path).and_return('./spec/fixtures/base_env.yml')
          )
        end

        describe '#error_pool' do
          it 'says zafira not enabled' do
            loader.call
            expect(loader.dammed?).to eq(true)
            expect(loader.error_pool).to match(/ZAFIRA is not enabled./)
          end
        end
      end
    end

    context 'env loaded and' do
      before do
        allow(loader).to(
          receive(:file_path).and_return('./spec/fixtures/base_env.yml')
        )
      end

      it 'has requried fields' do
        allow(client).to receive(:disabled?).and_return(false)
        allow(loader).to receive(:load_env_variables)

        loader.call
        expect(loader.dammed?).to eq(false)
        expect(env.zafira_access_token).to eq('token')
        expect(env.zafira_api_url).to eq('api-url')
        expect(env.zafira_project_name).to eq('project-name')
        expect(env.test_suite_config_file).to eq('conf-file')
      end
    end
  end
end
