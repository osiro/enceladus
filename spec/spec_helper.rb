require 'simplecov'

SimpleCov.start do
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

  c.before do
    Enceladus::Configuration::Api.instance.send(:api_key=, "token")
  end
end