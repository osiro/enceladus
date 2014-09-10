class FactoryConfigurationResponse < ApiResource
  attr_accessor :base_url, :secure_base_url, :backdrop_sizes, :logo_sizes, :poster_sizes, :profile_sizes, :still_sizes, :change_keys

  def to_json
    {
      images: {
        base_url: base_url,
        secure_base_url: secure_base_url,
        backdrop_sizes: backdrop_sizes,
        logo_sizes: logo_sizes,
        poster_sizes: poster_sizes,
        profile_sizes: profile_sizes,
        still_sizes: still_sizes
      },
      change_keys: change_keys
    }.to_json
  end
end

FactoryGirl.define do
  factory :configuration_response, class: FactoryConfigurationResponse do
    base_url "http://test.com/"
    secure_base_url "https://test.com/"
    backdrop_sizes [ "w300", "w780", "w1280", "original" ]
    logo_sizes [ "w45", "w92", "w154", "w185", "w300", "w500", "original" ]
    poster_sizes [ "w92", "w154", "w185", "w342", "w500", "w780", "original" ]
    profile_sizes [ "w45", "w185", "h632", "original" ]
    still_sizes [ "w92", "w185", "w300", "original" ]
    change_keys [ "adult", "also_known_as", "alternative_titles", "biography", "birthday", "budget", "cast",
      "character_names", "crew", "deathday", "general", "genres", "homepage", "images", "imdb_id", "name", "original_title",
      "overview", "plot_keywords", "production_companies", "production_countries", "releases", "revenue", "runtime",
      "spoken_languages", "status", "tagline", "title", "trailers", "translations" ]
  end
end