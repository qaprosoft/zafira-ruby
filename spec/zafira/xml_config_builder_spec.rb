# frozen_string_literal: true

describe Zafira::XmlConfigBuilder do
  let(:env) { build(:environment, :with_optional_data) }
  describe '#construct' do
    it do
      expect(Zafira::XmlConfigBuilder.new(env).construct).to eq(
        '<?xml version="1.0" encoding="UTF-8"?>' \
          '<config>' \
            '<arg>' \
              '<key>env</key>' \
              '<value>env</value>' \
            '</arg>' \
            '<arg>' \
              '<key>platform</key>' \
              '<value>platform</value>' \
            '</arg>' \
            '<arg>' \
              '<key>browser</key>' \
              '<value>browser</value>' \
            '</arg>' \
            '<arg>' \
              '<key>browser_version</key>' \
              '<value>browser_version</value>' \
            '</arg>' \
            '<arg>' \
              '<key>app_version</key>' \
              '<value>app_version</value>' \
            '</arg>' \
          '</config>'
      )
    end
  end
end
