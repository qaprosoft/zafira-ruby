# frozen_string_literal: true

module Zafira
  module Models
    class ZafiraStatus
      attr_accessor :available
    end

    class ZafiraStatus
      class Builder
        AVAILABLE_STATUS = 200

        def initialize(response)
          self.response = response
        end

        def construct
          return nil if response.code != 200

          status = ZafiraStatus.new
          status.available = true
          status
        end

        private

        attr_accessor :response
      end
    end
  end
end
