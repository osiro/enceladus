class Enceladus::Movie < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [ :adult, :backdrop_path, :id, :original_title, :release_date, :poster_path, :youtube_trailers,
    :popularity, :title, :vote_average, :vote_count, :belongs_to_collection, :budget, :homepage, :imdb_id, :releases,
    :overview, :revenue, :runtime, :status, :tagline, :genres, :production_companies, :production_countries, :spoken_languages,
    :rating ].map(&:freeze).freeze

  attr_accessor *RESOURCE_ATTRIBUTES

  def self.find(id)
    build_single_resource(Enceladus::Requester.get("movie/#{id}", default_params))
  end

  def self.find_by_title(title)
    Enceladus::MovieCollection.new("search/movie", { query: title })
  end

  def self.upcoming
    Enceladus::MovieCollection.new("movie/upcoming")
  end

  def self.now_playing
    Enceladus::MovieCollection.new("movie/now_playing")
  end

  def self.popular
    Enceladus::MovieCollection.new("movie/popular")
  end

  def self.top_rated
    Enceladus::MovieCollection.new("movie/top_rated")
  end

  def reload
    rebuild_single_resource(Enceladus::Requester.get("movie/#{id}"))
  end

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

  def genres=(genres_from_response)
    @genres = Enceladus::Genre.build_collection(genres_from_response)
  end

  def production_companies=(production_companies_from_response)
    @production_companies = Enceladus::ProductionCompany.build_collection(production_companies_from_response)
  end

  def production_countries=(production_countries_from_response)
    @production_countries = Enceladus::ProductionCountry.build_collection(production_countries_from_response)
  end

  def spoken_languages=(spoken_languages_from_response)
    @spoken_languages = Enceladus::SpokenLanguage.build_collection(spoken_languages_from_response)
  end

  def releases=(releases_from_response)
    if !releases_from_response.nil? && !releases_from_response.countries?
      @releases = Enceladus::Release.build_collection(releases_from_response.countries)
    end
  end

  def youtube_trailers=(trailers_from_response)
    if !trailers_from_response.nil? && !trailers_from_response.youtube.nil?
      @youtube_trailers = Enceladus::YouTubeTrailer.build_collection(trailers_from_response.youtube)
    end
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
