class ConfigurationResponse
  attr_accessor :base_url, :secure_base_url, :backdrop_sizes, :logo_sizes, :poster_sizes, :profile_sizes, :still_sizes, :change_keys

  def initialize
    self.base_url = "http://test.com/"
    self.secure_base_url = "https://test.com/"
    self.backdrop_sizes = [ "w300", "w780", "w1280", "original" ]
    self.logo_sizes = [ "w45", "w92", "w154", "w185", "w300", "w500", "original" ]
    self.poster_sizes = [ "w92", "w154", "w185", "w342", "w500", "w780", "original" ]
    self.profile_sizes = [ "w45", "w185", "h632", "original" ]
    self.still_sizes = [ "w92", "w185", "w300", "original" ]
    self.change_keys = [ "adult", "also_known_as", "alternative_titles", "biography", "birthday", "budget", "cast",
      "character_names", "crew", "deathday", "general", "genres", "homepage", "images", "imdb_id", "name", "original_title",
      "overview", "plot_keywords", "production_companies", "production_countries", "releases", "revenue", "runtime",
      "spoken_languages", "status", "tagline", "title", "trailers", "translations" ]
  end

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