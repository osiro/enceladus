require "codeclimate-test-reporter"
SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,CodeClimate::TestReporter::Formatter]
  add_filter "/support/responses"
end

require 'rspec'
require 'json'
require 'webmock/rspec'
require 'byebug'
require 'enceladus'
require 'factory_girl'
require 'faker'
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
