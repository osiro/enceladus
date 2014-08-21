require 'singleton'
require 'uri'

module Enceladus::Configuration
  class Api
    include Singleton

    attr_reader :base_url, :version, :api_key
    attr_accessor :include_adult

    def initialize
      self.base_url = "https://api.themoviedb.org".freeze
      self.version = "3".freeze
      self.include_adult = false
    end

    def connect(api_key)
      begin
        self.api_key = api_key
        Enceladus::Configuration::Image.instance.setup!
        true
      rescue Enceladus::Exception::Api
        self.api_key = nil
        Enceladus::Configuration::Image.instance.reset!
        false
      end
    end

    def url_for(action, params={})
      params[:api_key] = api_key
      url = URI.join(base_url, "/#{version}/", action)
      url.query = URI.encode_www_form(params)
      url.to_s
    end

  private
    attr_writer :base_url, :version, :api_key
  end
end