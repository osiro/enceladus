class MovieResponse
  attr_accessor :adult, :backdrop_path, :belongs_to_collection, :budget, :genres, :homepage, :id, :imdb_id, :original_title,
    :overview, :popularity, :poster_path, :production_companies, :production_countries, :release_date,
    :revenue, :runtime, :spoken_languages, :status, :tagline, :title, :vote_average, :vote_count, :releases, :trailers

  def initialize
    self.adult = false
    self.backdrop_path = "/tori_black.jpg"
    self.belongs_to_collection = nil
    self.budget = 63000000
    self.genres = [ { id: 28, name: "Action" } ]
    self.homepage = "http://www.google.com"
    self.id = 550
    self.imdb_id = "tt0137523"
    self.original_title = "Original Title"
    self.overview = "The overview goes here..."
    self.popularity = 4.5
    self.poster_path = "belladonna.jpeg"
    self.production_companies = [ { name: "19th Century Foxxx", id: 25 } ]
    self.production_countries = [ { iso_3166_1: "DE", name: "Germany" } ]
    self.release_date = "1999-10-14"
    self.revenue = 100853753
    self.runtime = 139
    self.spoken_languages = [ { iso_639_1: "en", name: "English" } ]
    self.status = "Released"
    self.tagline = "Aqui tem um bando de louco...."
    self.title = "Title goes here"
    self.vote_average = 5.5
    self.vote_count = 1234
    self.releases = { countries: [ { iso_3166_1: "US", certification: "R", release_date: "1999-10-14" } ] }
    self.trailers = { quicktime: [], youtube: [ { name: "Trailer 1", size: "HD", source: "SUXWAEX2jlg", type: "Trailer" } ] }
  end

  def to_hash
    {
      adult: adult,
      backdrop_path: backdrop_path,
      belongs_to_collection: belongs_to_collection,
      budget: budget,
      genres: genres,
      homepage: homepage,
      id: id,
      imdb_id: imdb_id,
      original_title: original_title,
      overview: overview,
      popularity: popularity,
      poster_path: poster_path,
      production_companies: production_companies,
      production_countries: production_countries,
      release_date: release_date,
      revenue: revenue,
      runtime: runtime,
      spoken_languages: spoken_languages,
      status: status,
      tagline: tagline,
      title: title,
      vote_average: vote_average,
      vote_count: vote_count,
      releases: releases,
      trailers: trailers
    }
  end

  def to_json
    to_hash.to_json
  end
end