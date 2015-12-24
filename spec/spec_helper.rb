require "codeclimate-test-reporter"

SimpleCov.add_filter "/support/responses"
SimpleCov.formatters = [ SimpleCov::Formatter::HTMLFormatter, CodeClimate::TestReporter::Formatter ]
SimpleCov.start

require 'rspec'
require 'json'
require 'webmock/rspec'
require 'enceladus'
require 'factory_girl'
require 'ffaker'
require File.dirname(__FILE__) + "/support/api_resource"

RSpec.configure do |config|
  config.mock_with :rspec

  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions

  WebMock.disable_net_connect!(allow: "codeclimate.com")

  config.before do |example|
    Enceladus::Configuration::Api.instance.send(:api_key=, "token")

    unless example.metadata[:logger_test]
      Enceladus::Logger.logger_output = nil
    end
  end
end
