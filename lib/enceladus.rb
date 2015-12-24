require File.dirname(__FILE__) + "/enceladus/version"
require File.dirname(__FILE__) + "/enceladus/exceptions"
require File.dirname(__FILE__) + "/enceladus/logger"
require File.dirname(__FILE__) + "/enceladus/requester"
require File.dirname(__FILE__) + "/enceladus/configuration/api"
require File.dirname(__FILE__) + "/enceladus/configuration/image"
require File.dirname(__FILE__) + "/enceladus/models/api_resource"
require File.dirname(__FILE__) + "/enceladus/models/api_paginated_collection"
require File.dirname(__FILE__) + "/enceladus/models/account"
require File.dirname(__FILE__) + "/enceladus/models/guest_account"
require File.dirname(__FILE__) + "/enceladus/models/genre"
require File.dirname(__FILE__) + "/enceladus/models/movie"
require File.dirname(__FILE__) + "/enceladus/models/movie_collection"
require File.dirname(__FILE__) + "/enceladus/models/cast"
require File.dirname(__FILE__) + "/enceladus/models/alternative_title"
require File.dirname(__FILE__) + "/enceladus/models/production_company"
require File.dirname(__FILE__) + "/enceladus/models/production_company_collection"
require File.dirname(__FILE__) + "/enceladus/models/production_country"
require File.dirname(__FILE__) + "/enceladus/models/release"
require File.dirname(__FILE__) + "/enceladus/models/spoken_language"
require File.dirname(__FILE__) + "/enceladus/models/you_tube_trailer"

module Enceladus

  # Responsible for authenticating Enceladus and fetching the account configuration.
  # This method hits the following TMDb endpoints:
  # - https://api.themoviedb.org/3/configuration
  #
  # You can also provide the following optional arguments:
  # - include_image_language: find backdrops and posters in a specific language (check out http://docs.themoviedb.apiary.io session: Image Languages)
  # - include_adult: includes adult movies in searchers
  # - language: returns content in a specified language
  #
  # Notes:
  #
  # - The arguments include_image_language and language must be a valid code from ISO_639-1 list, check this out for more info: http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
  #
  # - TMDb API does not fallback to English in a translation for a specific data is missing.
  #
  # Examples:
  #
  #   Enceladus.connect("0f76454c7b22300e457800cc20f24ae9")
  #   Enceladus.connect("0f76454c7b22300e457800cc20f24ae9", { include_image_language: "pt", language: "pt", include_adult: true })
  #
  def self.connect(api_key, options={})
    Enceladus::Configuration::Api.instance.tap do |api|
      api.connect(api_key)
      api.include_adult = options[:include_adult] || false
      api.language = options[:language] || "en"
    end

    Enceladus::Configuration::Image.instance.include_image_language = options[:include_image_language] || "en"
  end
end
