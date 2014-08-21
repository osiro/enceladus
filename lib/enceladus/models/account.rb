class Enceladus::Account < Enceladus::ApiResource

  RESOURCE_ATTRIBUTES = [:id, :include_adult, :iso_3166_1, :iso_639_1, :name, :username, :session_id].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES

  def initialize(username, password)
    self.username = username
    self.password = password
    start_authentication_workflow
  end

  def favorite_movie!(movie_id)
    toggle_favorite_movie(movie_id, true)
  end

  def unfavorite_movie!(movie_id)
    toggle_favorite_movie(movie_id, false)
  end

  def add_to_watchlist!(movie_id)
    toggle_movie_watchlist(movie_id, true)
  end

  def remove_from_watchlist!(movie_id)
    toggle_movie_watchlist(movie_id, false)
  end

  def favorite_movies
    Enceladus::MovieCollection.new("account/#{id}/favorite/movies", { session_id: session_id }) if authenticated?
  end

  def rated_movies
    Enceladus::MovieCollection.new("account/#{id}/rated/movies", { session_id: session_id }) if authenticated?
  end

  def watchlist
    Enceladus::MovieCollection.new("account/#{id}/watchlist/movies", { session_id: session_id }) if authenticated?
  end

private
  attr_accessor :request_token, :password

  def toggle_favorite_movie(movie_id, favorite)
     if authenticated?
      params = { session_id: session_id }
      form_data = { media_type: "movie", media_id: movie_id, favorite: favorite }
      Enceladus::Requester.post("account/#{id}/favorite", params, form_data)
    end
  end

  def toggle_movie_watchlist(movie_id, watchlist)
     if authenticated?
      params = { session_id: session_id }
      form_data = { media_type: "movie", media_id: movie_id, watchlist: watchlist }
      Enceladus::Requester.post("account/#{id}/watchlist", params, form_data)
    end
  end

  def authenticated?
    id && session_id
  end

  def start_authentication_workflow
    request_authentication_token
    authenticate
    open_session
    rebuild_single_resource(Enceladus::Requester.get("account", { session_id: session_id }))
    self.password = self.request_token = nil
  end

  def request_authentication_token
    token_info = Enceladus::Requester.get("authentication/token/new")
    self.request_token = token_info.request_token
  end

  def authenticate
    params = { request_token: request_token, username: username, password: password }
    Enceladus::Requester.get("authentication/token/validate_with_login", params).success
  end

  def open_session
    params = { request_token: request_token }
    self.session_id = Enceladus::Requester.get("authentication/session/new", params).session_id
  end
end