# frozen_string_literal: true

# TODO: remove
module Zafira
  module Concerns
    module Operationable
      include Waterfall
      include Zafira::Logging

      def call
        chain { check_zafira_availability }

        # if all is ok then let's continue
        chain { yield }
        on_dam { mark_client_as_invalid }
      end

      private

      def check_zafira_availability
        dam('Zafira is unavailable') if client.unavailable

        dam('Zafira is not enabled') if client.disabled?
      end

      def mark_client_as_invalid
        # log only if zafira currenty available
        log_error unless client.unavailable

        # and then for future mark client is unavailable
        client.unavailable = true
      end

      def log_error
        logger.error(error_pool) if error_pool
        logger.error('Zafira integration became unavailable.')
        logger.error('Tests will run in usual mode')
      end
    end
  end
end
