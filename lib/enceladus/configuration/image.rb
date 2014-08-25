require 'singleton'

module Enceladus::Configuration
  class Image
    include Singleton

    attr_reader :base_url, :secure_base_url, :backdrop_sizes, :logo_sizes, :poster_sizes, :profile_sizes, :still_sizes
    attr_accessor :include_image_language

    def initialize #:nodoc:#
      reset!
    end

    # Fetches the TMDb account's configuration data.
    # This method hits the following TMDb endpoints:
    # - https://api.themoviedb.org/3/configuration
    #
    def setup!
      configuration = Enceladus::Requester.get("configuration").images
      self.base_url = configuration.base_url.freeze
      self.secure_base_url = configuration.secure_base_url.freeze
      self.backdrop_sizes = configuration.backdrop_sizes.map(&:freeze).freeze
      self.logo_sizes = configuration.logo_sizes.map(&:freeze).freeze
      self.poster_sizes = configuration.poster_sizes.map(&:freeze).freeze
      self.profile_sizes = configuration.profile_sizes.map(&:freeze).freeze
      self.still_sizes = configuration.still_sizes.map(&:freeze).freeze
      self
    end

    # Reset or nullify all image configurations.
    #
    def reset!
      self.base_url = nil
      self.secure_base_url = nil
      self.backdrop_sizes = []
      self.logo_sizes = []
      self.logo_sizes = []
      self.poster_sizes = []
      self.profile_sizes = []
      self.still_sizes = []
      self
    end

    # Returns an array of strings containing URL's for movie/person/tv assets.
    # Be aware to setup the configuration beforehand, by running:
    #
    #   Enceladus::Configuration::Image.instance.setup!
    #
    # The following arguments are necessary:
    # - type: the type of asset you're providing, must be one of "backdrop", "logo", "poster" or "profile".
    # - image_path: /gWyevEz9NT5tON6kdhxsmfvdJ40.jpg
    #
    # Examples:
    #
    #   Enceladus::Configuration::Image.instance.url_for("backdrop", )
    #   => ["http://image.tmdb.org/t/p/w300/gWyevEz9NT5tON6kdhxsmfvdJ40.jpg", "http://image.tmdb.org/t/p/w780/gWyevEz9NT5tON6kdhxsmfvdJ40.jpg", "http://image.tmdb.org/t/p/w1280/gWyevEz9NT5tON6kdhxsmfvdJ40.jpg", "http://image.tmdb.org/t/p/original/gWyevEz9NT5tON6kdhxsmfvdJ40.jpg"]
    #
    def url_for(type, image_path)
      types =  ["backdrop", "logo", "poster", "profile"]
      raise ArgumentError.new("type must be one of #{types}") unless types.include?(type)
      return [] if image_path.nil? || image_path.empty? && valid?

      send("#{type}_sizes").map do |size|
        "#{base_url}#{size}#{image_path}"
      end
    end

    # Returns a boolean indicating whether the Image configurations are valid or not.
    #
    def valid?
      !base_url.nil? &&
      !secure_base_url.nil? &&
      backdrop_sizes.any? &&
      logo_sizes.any? &&
      poster_sizes.any? &&
      profile_sizes.any? &&
      still_sizes.any?
    end

  private
    attr_writer :base_url, :secure_base_url, :backdrop_sizes, :logo_sizes, :poster_sizes, :profile_sizes, :still_sizes
  end
end