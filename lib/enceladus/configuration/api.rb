require 'singleton'
require 'uri'

module Enceladus::Configuration
  class Api
    include Singleton

    attr_reader :base_url, :version, :api_key
    attr_accessor :include_adult, :language

    def initialize #:nodoc:#
      self.base_url = "https://api.themoviedb.org".freeze
      self.version = "3".freeze
      self.include_adult = false
      self.language = "en"
    end

    # Fetches the TMDb account configuration.
    # This method hits the following TMDb endpoints:
    # - https://api.themoviedb.org/3/configuration
    #
    # Once the request has succeeded, Enceladus will populate the following Enceladus::Configuration::Image attributes:
    # base_url, secure_base_url, backdrop_sizes, logo_sizes, poster_sizes, profile_sizes and still_sizes.
    #
    # A failing request will reset/nullify all those mentioned attributes.
    #
    # Return a boolean indicating whether the request has succeeded or not.
    #
    # Examples:
    #
    #   Enceladus::Configuration::Api.instance.connect("cceebf51cb1f8d707d10a132d9544b76")
    #
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

    # Returns a string with a URL for one of TMDb API endpoints.
    # Examples:
    #
    #   Enceladus::Configuration::Api.instance.url_for("movies", { term: "Lola Benvenutti" })
    #   => https://api.themoviedb.org/3/movies?term=Lola+Benvenutti&api_key=token
    #
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