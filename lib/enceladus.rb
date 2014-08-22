require File.dirname(__FILE__) + "/enceladus/version"
require File.dirname(__FILE__) + "/enceladus/exceptions"
require File.dirname(__FILE__) + "/enceladus/requester"
require File.dirname(__FILE__) + "/enceladus/configuration/api"
require File.dirname(__FILE__) + "/enceladus/configuration/image"
require File.dirname(__FILE__) + "/enceladus/models/api_resource"
require File.dirname(__FILE__) + "/enceladus/models/api_paginated_collection"
require File.dirname(__FILE__) + "/enceladus/models/account"
require File.dirname(__FILE__) + "/enceladus/models/guest_account"
require File.dirname(__FILE__) + "/enceladus/models/genre"
require File.dirname(__FILE__) + "/enceladus/models/movie"
require File.dirname(__FILE__) + "/enceladus/models/cast"
require File.dirname(__FILE__) + "/enceladus/models/movie_collection"
require File.dirname(__FILE__) + "/enceladus/models/production_company"
require File.dirname(__FILE__) + "/enceladus/models/production_country"
require File.dirname(__FILE__) + "/enceladus/models/release"
require File.dirname(__FILE__) + "/enceladus/models/spoken_language"
require File.dirname(__FILE__) + "/enceladus/models/you_tube_trailer"

module Enceladus
  def self.connect(api_key, options={ include_image_language: "en", include_adult: false })
    Enceladus::Configuration::Api.instance.tap do |api|
      api.connect(api_key)
      api.include_adult = options[:include_adult]
    end

    Enceladus::Configuration::Image.instance.include_image_language = options[:include_image_language]
  end
end
