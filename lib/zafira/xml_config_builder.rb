# frozen_string_literal: true

#  zafira supports xml ONLY
module Zafira
  class XmlConfigBuilder
    def initialize(environment)
      self.environment = environment
    end

    def construct
      instance.config { |config| map_config(config) }
    end

    private

    def map_config(config)
      build_tag config, 'env', environment.env
      build_tag config, 'platform', environment.platform
      build_tag config, 'browser', environment.browser
      build_tag config, 'browser_version', environment.browser_version
      build_tag config, 'app_version', environment.app_version
    end

    def build_tag(config, key, value)
      config.arg do |argument|
        argument.key key
        argument.value value
      end
    end

    def instance
      xml = ::Builder::XmlMarkup.new
      xml.instruct! :xml, encoding: 'UTF-8'
      xml
    end

    attr_accessor :environment
  end
end
