require_relative "./enceladus/configuration/api"
require_relative "./enceladus/configuration/image"

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
    Enceladus::Configuration::Image.instance.include_image_language = options[:include_image_language] || "en"
    
    api = Enceladus::Configuration::Api.instance
    api.include_adult = options[:include_adult] || false
    api.language = options[:language] || "en"
    api.connect(api_key)
  end
end
