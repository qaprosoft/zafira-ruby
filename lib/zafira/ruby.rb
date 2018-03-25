# frozen_string_literal: true

require 'zafira/ruby/version'

require 'waterfall'
require 'builder'
require 'httparty'

require 'webmock'

# loggers
require 'logger'
require 'zafira/logging.rb'

# modules
require 'zafira/concerns/apiable.rb'
require 'zafira/concerns/operationable.rb'
require 'zafira/concerns/formatterable.rb'

# models
require 'zafira/models/environment.rb'
require 'zafira/models/job.rb'
require 'zafira/models/run.rb'
require 'zafira/models/test_suite.rb'
require 'zafira/models/test_case.rb'
require 'zafira/models/zafira_status.rb'
require 'zafira/models/user.rb'
require 'zafira/models/zafira_token.rb'

# api
require 'zafira/api/job/start.rb'
require 'zafira/api/test_suite/create.rb'
require 'zafira/api/run/start.rb'
require 'zafira/api/run/finish.rb'
require 'zafira/api/test_case/create.rb'
require 'zafira/api/test_case/start.rb'
require 'zafira/api/test_case/finish.rb'
require 'zafira/api/zafira_status.rb'
require 'zafira/api/user/create.rb'
require 'zafira/api/user/create/run_owner_params.rb'
require 'zafira/api/user/create/test_suite_owner_params.rb'
require 'zafira/api/user/refresh_token.rb'

# operations
require 'zafira/operations/run/start.rb'
require 'zafira/operations/run/finish.rb'
require 'zafira/operations/environment/load.rb'
require 'zafira/operations/test_suite/create.rb'
require 'zafira/operations/job/start.rb'
require 'zafira/operations/test_case/finishable.rb'
require 'zafira/operations/test_case/create.rb'
require 'zafira/operations/test_case/start.rb'
require 'zafira/operations/test_case/pass.rb'
require 'zafira/operations/test_case/fail.rb'
require 'zafira/operations/test_case/skip.rb'
require 'zafira/operations/zafira_status/check.rb'
require 'zafira/operations/user/registrate.rb'
require 'zafira/operations/user/refresh_token.rb'
require 'zafira/operations/zafira_client/validate_handlers.rb'

# handlers
require 'zafira/handlers/test_case/rspec.rb'
require 'zafira/handlers/finished_test_case/rspec/base.rb'
require 'zafira/handlers/finished_test_case/rspec/failed.rb'
require 'zafira/handlers/finished_test_case/rspec/passed.rb'
require 'zafira/handlers/finished_test_case/rspec/skipped.rb'
require 'zafira/handlers/test_case/cucumber.rb'
require 'zafira/handlers/finished_test_case/cucumber/base.rb'
require 'zafira/handlers/finished_test_case/cucumber/failed.rb'
require 'zafira/handlers/finished_test_case/cucumber/passed.rb'
require 'zafira/handlers/finished_test_case/cucumber/skipped.rb'

# clients
require 'zafira/client.rb'
# xml builders
require 'zafira/xml_config_builder.rb'

require 'zafira/cucumber/configuration.rb'

module Zafira
  module Ruby
  end
end
