class Enceladus::Movie < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [ :adult, :backdrop_path, :id, :original_title, :release_date, :poster_path, :youtube_trailers,
    :popularity, :title, :vote_average, :vote_count, :belongs_to_collection, :budget, :homepage, :imdb_id, :releases,
    :overview, :revenue, :runtime, :status, :tagline, :genres, :production_companies, :production_countries, :spoken_languages,
    :rating, :cast ].map(&:freeze).freeze

  attr_accessor *RESOURCE_ATTRIBUTES

  # Find a movie by TMDb ID or imdb_id.
  # Examples:
  #   Enceladus::Movie.find(550)
  #   Enceladus::Movie.find("tt0137523")
  #
  def self.find(id)
    build_single_resource(Enceladus::Requester.get("movie/#{id}", default_params))
  end

  # Find movies by title.
  # Example:
  #   Enceladus::Movie.find_by_title("emmanuelle")
  #
  def self.find_by_title(title)
    Enceladus::MovieCollection.new("search/movie", { query: title })
  end

  # Returns a paginated collection of upcoming movies.
  # Resources are paginates and respond to methods such as: next_page, all, previous_page, etc...
  # Examples:
  #
  #   collection = Enceladus::Movie.upcoming
  #   collection.all
  #   => [Movie, Movie, ...]
  #   collection.current_page
  #   => 1
  #   collection.next_page
  #   => [Movie, Movie, ...]
  #   collection.current_page
  #   => 2
  #
  def self.upcoming
    Enceladus::MovieCollection.new("movie/upcoming")
  end

  # Returns a paginated collection of movies playing in theatres.
  def self.now_playing
    Enceladus::MovieCollection.new("movie/now_playing")
  end

  # Returns a paginated collection of popular movies.
  def self.popular
    Enceladus::MovieCollection.new("movie/popular")
  end

  # Returns a paginated collection of top rated movies.
  def self.top_rated
    Enceladus::MovieCollection.new("movie/top_rated")
  end

  # Given a movie, this method returns a paginated collection of similar movies.
  def similar
    Enceladus::MovieCollection.new("movie/#{id}/similar", Enceladus::Movie.default_params)
  end

  # Fetchs details of movie information on TMDb API.
  def reload
    rebuild_single_resource(Enceladus::Requester.get("movie/#{id}"))
  end

  # Rate a movie.
  # The argument account can be Enceladus::Account or Enceladus::GuestAccount.
  # The argument rating must be an numeric value between 0 and 10.
  # Examples:
  #   movie = Enceladus::Movie.find(550)
  #   guest_account = Enceladus::GuestAccount.new
  #   movie.rate!(guest_account, 7.5)
  #
  #   account = Enceladus::Account.new("username", "password")
  #   movie.rate!(account, 8.3)
  #
  # TMDb expects the rating value to be divisors of 0.5, this method rounds the value properly before making the request.
  #
  def rate!(account, rating)
    params = {}
    if account.kind_of?(Enceladus::Account)
      params[:session_id] = account.session_id
    elsif account.kind_of?(Enceladus::GuestAccount)
      params[:guest_session_id] = account.session_id
    else
      raise Enceladus::Exception::ArgumentError.new("account must be one of Enceladus::Account or Enceladus::GuestAccount")
    end

    form_data = { value: (rating * 2).round / 2.0 }
    Enceladus::Requester.post("movie/#{id}/rating", params, form_data)
  end

  # Method used by Enceladus::ApiResource to save genres fetched by TMDb API.
  def genres=(genres_from_response)
    @genres = Enceladus::Genre.build_collection(genres_from_response)
  end

  # Method used by Enceladus::ApiResource to save production companies fetched by TMDb API.
  def production_companies=(production_companies_from_response)
    @production_companies = Enceladus::ProductionCompany.build_collection(production_companies_from_response)
  end

  # Method used by Enceladus::ApiResource to save production countries fetched by TMDb API.
  def production_countries=(production_countries_from_response)
    @production_countries = Enceladus::ProductionCountry.build_collection(production_countries_from_response)
  end

  # Method used by Enceladus::ApiResource to save spoken languages fetched by TMDb API.
  def spoken_languages=(spoken_languages_from_response)
    @spoken_languages = Enceladus::SpokenLanguage.build_collection(spoken_languages_from_response)
  end

  # Method used by Enceladus::ApiResource to save releases fetched by TMDb API.
  def releases=(releases_from_response)
    if !releases_from_response.nil? && !releases_from_response.countries?
      @releases = Enceladus::Release.build_collection(releases_from_response.countries)
    end
  end

  # Method used by Enceladus::ApiResource to save trailers fetched by TMDb API.
  def youtube_trailers=(trailers_from_response)
    if !trailers_from_response.nil? && !trailers_from_response.youtube.nil?
      @youtube_trailers = Enceladus::YouTubeTrailer.build_collection(trailers_from_response.youtube)
    end
  end

  # Returns an array of Cast for the movie.
  def cast
    @cast ||= Enceladus::Cast.build_collection(Enceladus::Requester.get("movie/#{id}/credits").cast)
  end

  # Returns an array containing URL's (as string) for the movie background picture.
  def backdrop_urls
    Enceladus::Configuration::Image.instance.url_for("backdrop", backdrop_path)
  end

  # Returns an array containing URL's (as string) for the movie poster picture.
  def poster_urls
    Enceladus::Configuration::Image.instance.url_for("poster", poster_path)
  end

private
  def self.build_single_resource(resource_from_response)
    super(resource_from_response).tap do |resource|
      resource.youtube_trailers=(resource_from_response.trailers)
    end
  end

  def rebuild_single_resource(resource_from_response)
    super(resource_from_response).tap do |resource|
      self.youtube_trailers=(resource_from_response.trailers)
    end
  end

  def self.default_params
    include_image_language = Enceladus::Configuration::Image.instance.include_image_language
    { append_to_response: "releases,trailers", include_image_language: include_image_language }
  end
end
