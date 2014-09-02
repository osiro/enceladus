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

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |file| require file }

RSpec.configure do |c|
  c.mock_with :rspec

  WebMock.disable_net_connect!(allow: "codeclimate.com")

  c.before do |example|
    Enceladus::Configuration::Api.instance.send(:api_key=, "token")

    unless example.metadata[:logger_test]
      Enceladus::Logger.logger_output = nil
    end
  end
end
