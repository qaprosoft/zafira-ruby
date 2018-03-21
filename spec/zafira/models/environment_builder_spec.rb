# frozen_string_literal: true

describe Zafira::Models::Environment::Builder do
  let(:yaml_data) do
    {
      # required params
      'zafira_api_url' => 'zafira_api_url',
      'zafira_access_token' => 'access_token',
      'zafira_project_name' => 'project_name',
      'test_suite_config_file' => 'suite_config_file',

      # ci params
      'ci_username' => 'ci_username',
      'ci_user_email' => 'ci_user_email',
      'ci_user_first_name' => 'ci_user_first_name',
      'ci_user_last_name' => 'ci_user_last_name',
      'ci_job_name' => 'ci_job_name',
      'ci_job_url' => 'ci_job_url',
      'ci_host' => 'ci_host',
      'ci_test_run_uuid' => 'ci_test_run_uuid',
      'ci_run_build_number' => 'ci_run_build_number',

      # test suite params
      'test_suite_name' => 'test_suite_name',
      'test_suite_description' => 'test_suite_description',
      'test_suite_username' => 'test_suite_username',
      'test_suite_email' => 'test_suite_email',
      'test_suite_first_name' => 'test_suite_first_name',
      'test_suite_last_name' => 'test_suite_last_name',

      # optionals
      'env' => 'env',
      'platform' => 'platform',
      'browser' => 'browser',
      'browser_version' => 'browser_version',
      'app_version' => 'app_version',
      'refresh_token' => 'refresh_token',
      'zafira_enabled' => 'zafira_enabled'
    }
  end

  let(:builder) { Zafira::Models::Environment::Builder.new(yaml_data) }

  let(:env) { builder.construct }

  describe '#construct' do
    it 'builds required params' do
      expect(env.zafira_api_url).to eq('zafira_api_url')
      expect(env.zafira_access_token).to eq('access_token')
      expect(env.zafira_project_name).to eq('project_name')
      expect(env.test_suite_config_file).to eq('suite_config_file')
    end

    it 'builds ci params' do
      expect(env.ci_username).to eq('ci_username')
      expect(env.ci_user_email).to eq('ci_user_email')
      expect(env.ci_user_first_name).to eq('ci_user_first_name')
      expect(env.ci_user_last_name).to eq('ci_user_last_name')
      expect(env.ci_job_name).to eq('ci_job_name')
      expect(env.ci_job_url).to eq('ci_job_url')
      expect(env.ci_host).to eq('ci_host')
      expect(env.ci_test_run_uuid).to eq('ci_test_run_uuid')
      expect(env.ci_run_build_number).to eq('ci_run_build_number')
    end

    it 'builds test suite params' do
      expect(env.test_suite_name).to eq('test_suite_name')
      expect(env.test_suite_description).to eq('test_suite_description')
      expect(env.test_suite_username).to eq('test_suite_username')
      expect(env.test_suite_email).to eq('test_suite_email')
      expect(env.test_suite_first_name).to eq('test_suite_first_name')
      expect(env.test_suite_last_name).to eq('test_suite_last_name')
    end

    it 'builds optional params' do
      expect(env.env).to eq('env')
      expect(env.platform).to eq('platform')
      expect(env.browser).to eq('browser')
      expect(env.browser_version).to eq('browser_version')
      expect(env.app_version).to eq('app_version')
      expect(env.refresh_token).to eq('refresh_token')
      expect(env.zafira_enabled).to eq('zafira_enabled')
    end
  end
end
