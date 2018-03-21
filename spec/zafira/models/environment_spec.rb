# frozen_string_literal: true

describe Zafira::Models::Environment do
  describe 'CONSTANTS' do
    describe 'MANDATORY_PARAMS' do
      let(:constant) { Zafira::Models::Environment::MANDATORY_PARAMS }

      it { expect(constant).to include('zafira_api_url') }
      it { expect(constant).to include('zafira_access_token') }
      it { expect(constant).to include('zafira_project_name') }
      it { expect(constant).to include('test_suite_config_file') }
      it { expect(constant).to include('test_suite_name') }
      it { expect(constant).to include('ci_job_name') }
      it { expect(constant).to include('ci_job_url') }
      it { expect(constant).to include('ci_host') }
      it { expect(constant).to include('ci_test_run_uuid') }
      it { expect(constant).to include('ci_run_build_number') }
      it { expect(constant).to include('zafira_enabled') }
    end

    describe 'CI_USER_PARAMS' do
      let(:constant) { Zafira::Models::Environment::CI_USER_PARAMS }

      it { expect(constant).to include('ci_username') }
      it { expect(constant).to include('ci_user_email') }
      it { expect(constant).to include('ci_user_first_name') }
      it { expect(constant).to include('ci_user_last_name') }
    end

    describe 'TEST_SUITE_PARAMS' do
      let(:constant) { Zafira::Models::Environment::TEST_SUITE_PARAMS }

      it { expect(constant).to include('test_suite_description') }
    end

    describe 'TEST_SUITE_USER_PARAMS' do
      let(:constant) { Zafira::Models::Environment::TEST_SUITE_USER_PARAMS }

      it { expect(constant).to include('test_suite_username') }
      it { expect(constant).to include('test_suite_email') }
      it { expect(constant).to include('test_suite_first_name') }
      it { expect(constant).to include('test_suite_last_name') }
    end

    describe 'OPTIONAL_PARAMS' do
      let(:constant) { Zafira::Models::Environment::OPTIONAL_PARAMS }

      it { expect(constant).to include('env') }
      it { expect(constant).to include('platform') }
      it { expect(constant).to include('browser') }
      it { expect(constant).to include('browser_version') }
      it { expect(constant).to include('app_version') }
      it { expect(constant).to include('refresh_token') }
    end
  end
end
