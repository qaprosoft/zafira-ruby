# frozen_string_literal: true

module Zafira
  module Logging
    def logger
      Logging.logger
    end

    def self.logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
