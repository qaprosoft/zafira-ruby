# Zafira::Ruby

Zafira listener for RSpec and Cucumber.

It was tested with ruby-2.4.0 only at the moment.

You may need to require Zafira listener in your configuration file  `require 'zafira/ruby'`

If you use `webmock` in your project you need to stub Zafira api endpoint. Here is example with localhost:

```ruby
WebMock.disable_net_connect!(net_http_connect_on_start: true, allow_localhost: true, allow: [/localhost/])
```

## Installation

Add this line to your application's Gemfile:

```
gem 'zafira-ruby', git: 'https://github.com/qaprosoft/zafira-ruby.git'
```

And then execute:

```
bundle
```

## RSpec usage

```
ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE=./path/to/config.yml <other env variables> bundle exec rspec spec/ -f Zafira::Rspec::Formatter -f doc
```

It was tested with RSpec 3.6 only at the moment.

## Cucumber usage

```
ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE=./path/to/config.yml <other env variables> bundle exec cucumber features/ -f pretty -f Zafira::Cucumber::Formatter --out
```

It was tested with Cucumber 3.0.1 only at the moment.

## STDOUT Output

After you finish setup you should see the following in your STDOUT.

```
I, [2018-03-22T00:00:30.872066 #9614]  INFO -- : ZAFIRA ENVIRONMENT PARAMS are loaded.
I, [2018-03-22T00:00:30.907035 #9614]  INFO -- : Zafira is available.
I, [2018-03-22T00:00:41.329842 #9614]  INFO -- : Run Owner #4 created.
I, [2018-03-22T00:00:41.414959 #9614]  INFO -- : TestSuite Owner #5 created.
I, [2018-03-22T00:00:41.511588 #9614]  INFO -- : TestSuite #79 created
I, [2018-03-22T00:00:41.535721 #9614]  INFO -- : Job #184 started
I, [2018-03-22T00:00:41.612432 #9614]  INFO -- : Run #211 started.
```

Then you can open Zafira and enjoy your Test Run :smiley:.

![screenshot from 2018-03-22 21-13-48](https://user-images.githubusercontent.com/3288759/37789827-f3577c56-2e15-11e8-8cba-952055f35fb2.png)

If your setup is incorrect you will see error in your STDOUT. Example:

```
E, [2018-03-22T20:46:56.477900 #32292] ERROR -- : PARAMS [ci_job_name,ci_job_url,ci_host,ci_test_run_uuid,ci_run_build_number,zafira_enabled] are required
E, [2018-03-22T20:46:56.477978 #32292] ERROR -- : Zafira integration became unavailable.
E, [2018-03-22T20:46:56.478007 #32292] ERROR -- : Tests will be run in usual mode
```

Exception above imply  you did not set some required variables.

## The reason why we use 2 formatters in examples

The reason why we use 2 formatters in exampes is that our Zafira formatter doesn't log test cases output to STDOUT. And if you don't use any other formatters(e.g. `doc` for RSpec or `pretty` for Cucumber) you will not get test cases log output. In Cucumber example we also use `--out` attribute because Cucumber doesn't allow to use 2 formatters with one stream and returns `All but one formatter must use --out, only one can print to each stream (or STDOUT)` exception. `--out` fixes this issue.

Please look at other possible environment and config variables.

## Possible environment and config variables
There are mandatory and optional variables.

You can setup each value either as environment variable or declare it in your config yml file. It's usefull when you have some dynamic variables(e.g. `ci_job_url` or `ci_test_run_uuid`) and you can put them as environment variables and static variables(e.g. `zafira_project_name` or `test_suite_description`, ...) goes to yml file.

Use `ZAFIRA_ENV_` prefix if yout want to use a parameter as environment variable.

Note: If you put your variable in two ways(in environment and config file) then env variable will override config file variable.

### Required variables

- **zafira_enabled**
  - Boolean. If `false` then tests will be run in usual mode.
- **zafira_api_url**
  - String. Url to Zafira api. Example: `http://localhost/zafira-ws`
- **zafira_access_token**
  - String. Zafira access token. It goes without Bearer prefix
- **zafira_project_name**
  - String. Zafira project name
- **test_suite_config_file**
  - String. Only available via env variable. It's path to the config yml file.
- **test_suite_name**
  - String. Test suite name
- **ci_job_name**
  - String. CI Job name
- **ci_job_url**
  - String. CI Job url
- **ci_host**
  - String. CI host
- **ci_test_run_uuid**
  - String. CI test run UUID
- **ci_run_build_number**
  - String. CI run build_number

### Optional variables

- **test_suite_description**
  - String. Test suite description  
- **test_suite_username**
  - String. Test suite owner username. By default it takes anonymous.
- **test_suite_email**
  - E-mail. Test suite owner email
- **test_suite_first_name**
  - String. Test suite owner first name
- **test_suite_last_name**
  - String. Test suite owner last name
- **ci_username**
  - Run owner username. By default it takes anonymous.
- **ci_user_email**
  - E-mail. Run owner email.
- **ci_user_first_name**
  - String. Run owner first name.
- **ci_user_last_name**
  - String. Run owner last name.
- **env**
  - String. freetext
- **platform**
  - String. freetext
- **browser**
  - String. freetext
- **browser_version**
  - String. freetext
- **app_version**
  - String. freetext
- **refresh_token**
  - String. freetext

## Possible config yml file.

Here you can see possible config yml.

Note: You have to pass `ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE` environment variable which is this config file path.

Here is example of config yml file:

```yml
zafira_enabled: true

zafira_api_url: "http://localhost/zafira-ws"
zafira_access_token: "token"
zafira_project_name: "project name"

test_suite_name: "QAPROSOFT - RSpec regression tests"
test_suite_description: "It's RSpec tests for gem description"

ci_job_name: "QAPROSOFT - Daily tests"
ci_host: "http://jenkins.qaprosoft.com"

# it's better to put this block to the env variables
# please, see `Possible env and config variables` description how to do it.
ci_job_url: "http://jenkins.qaprosoft.com/jobs/1"
ci_test_run_uuid: "00000000-0000-0000-0000-00000"
ci_run_build_number: "111"

# optional params
env: "PRODUCTION"
platform: "*"
browser: "chrome"
browser_version: "54.0.2840.71 (64-bit)"
app_version: "0.0.0.1"

# run owner params
ci_username: "run_owner_username"
ci_user_email: "run_owner_username@qaprosoft.com"
ci_user_first_name: "First name"
ci_user_last_name: "Last name"

# test suite params
test_suite_username: "test_sutie_owner_username"
test_suite_email: "test_sutie_owner_username@qaprosoft.com"
test_suite_first_name: "First name"
test_suite_last_name: "Last name"
```

## Zafira logging overrides

If you want to override a test case data that the listener sends to Zafira(fail/pass/skip message or test case base data) you can write your own handler(s) and setup it at your configuration file.

### RSpec example

Write your own handler class and setup it in your configuration file

```ruby
# you can override either one of them or all handlers
RSpec.configure do |config|
  config.test_case_handler_class = TestCaseHandler
  config.failed_test_case_handler_class = FailedTestCaseHandler
  config.passed_test_case_handler_class = PassedTestCaseHandler
  config.skipped_test_case_handler_class = SkippedTestCaseHandler
end
```

#### Test case base information handler

Example of handler class. Do not forget to inherit `Zafira::Handlers::TestCase::Rspec`

```ruby
# Available variables: example
# example is an instance of RSpec::Core::Example
# http://www.rubydoc.info/github/rspec/rspec-core/RSpec/Core/Example
class TestCaseHandler < Zafira::Handlers::TestCase::Rspec
  def test_class
    # now: example.metadata[:described_class].to_s
  end

  def test_method
    # now: example.metadata[:location]
  end

  def info
    # now: example.metadata[:full_description]
  end
end
```

#### Test case failed status handler

Example of handler class. Do not forget to inherit `Zafira::Handlers::FinishedTestCase::Rspec::Base`

```ruby
# Available variables: example
# example is an instance of RSpec::Core::Example
# http://www.rubydoc.info/github/rspec/rspec-core/RSpec/Core/Example
class FailedTestCaseHandler  < Zafira::Handlers::FinishedTestCase::Rspec::Base
  def message
    # now
    # output = "#{example.location}\n#{example.exception}"
    #
    # if example.exception.backtrace
    #   output += "\n" + example.exception.backtrace.join("\n")
    # end
    #
    # output
  end
end
```

#### Test case passed status handler

See an example with failed status

#### Test case passed status handler

See an example with failed status

### Cucumber example

Write your own handler class and setup it in your configuration file.

```ruby
# you can override either one of them or all handlers
module Cucumber
  class Configuration
    def test_case_handler_class
      TestCaseHandler
    end

    def failed_test_case_handler_class
      FailedTestCaseHandler
    end

    def skipped_test_case_handler_class
      SkippedTestCaseHandler
    end

    def passed_test_case_handler_class
      PassedTestCaseHander
    end
  end
end
```

#### Test case base information handler

Example of handler class. Do not to forget to inherit `Zafira::Handlers::TestCase::Cucumber`

```ruby
# Available variables: scenario
# scenario is an instance of Cucumber::Core::Test::Case
# http://www.rubydoc.info/github/cucumber/cucumber-ruby-core/Cucumber/Core/Test/Case
class TestCaseHandler < Zafira::Handlers::TestCase::Cucumber
  def test_class
    # now: scenario.source.first.name
  end

  def test_method
    # now: scenario.location.to_s
  end

  def info
    # now: scenario.name
  end
end
```

#### Test case failed status handler

Example of handler class. Do not forget to inherit `Zafira::Handlers::FinishedTestCase::Cucumber::Base`

```ruby
# Available variables: scenario, result
# scenario is an instance of Cucumber::Core::Test::Case
# http://www.rubydoc.info/github/cucumber/cucumber-ruby-core/Cucumber/Core/Test/Case
# result is an instance of Cucumber::Core::Test::Result
# one of http://www.rubydoc.info/github/cucumber/cucumber-ruby-core/Cucumber/Core/Test/Result
# check passed, failed, pending
class FailedTestCaseHandler  < Zafira::Handlers::FinishedTestCase::Cucumber::Base
  def message
    # now
    # "#{result.exception.message}\n" \
    # "#{result.exception.backtrace&.join("\n")}"
  end
end
```

#### Test case passed status handler

See an example with failed status

#### Test case passed status handler

See an example with failed status

## License

Code - [Apache Software License v2.0](http://www.apache.org/licenses/LICENSE-2.0)

Documentation and Site - [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/deed.en_US)
