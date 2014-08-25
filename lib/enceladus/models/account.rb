class Enceladus::Account < Enceladus::ApiResource

  RESOURCE_ATTRIBUTES = [:id, :include_adult, :iso_3166_1, :iso_639_1, :name, :username, :session_id].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES

  # Responsible for authenticating TMDb users.
  # Authentication of users follows the workflow: https://www.themoviedb.org/documentation/api/sessions
  # This method hits the following api endpoints:
  #
  # - http://api.themoviedb.org/3/authentication/token/new
  # - http://api.themoviedb.org/3/authentication/token/validate_with_login
  # - http://api.themoviedb.org/3/authentication/session/new
  # - http://api.themoviedb.org/3/account
  #
  # Example:
  #
  #   Enceladus::Account.new("bruna_ferraz", "dajhhd")
  #
  def initialize(username, password)
    self.username = username
    self.password = password
    start_authentication_workflow
  end

  # Adds movie to accounts favorite list.
  # Example:
  #
  #   account = Enceladus::Account.new("bruna_ferraz", "dajhhd")
  #   account.favorite_movie!(23444)
  #
  def favorite_movie!(movie_id)
    toggle_favorite_movie(movie_id, true)
  end

  # Removes movie to accounts favorite list.
  # Example:
  #
  #   account = Enceladus::Account.new("bruna_ferraz", "dajhhd")
  #   account.unfavorite_movie!(23444)
  #
  def unfavorite_movie!(movie_id)
    toggle_favorite_movie(movie_id, false)
  end

  # Adds movie to accounts watchlist.
  # Example:
  #
  #   account = Enceladus::Account.new("bruna_ferraz", "dajhhd")
  #   account.add_to_watchlist!(23444)
  #
  def add_to_watchlist!(movie_id)
    toggle_movie_watchlist(movie_id, true)
  end

  # Removes movie to accounts watchlist.
  # Example:
  #
  #   account = Enceladus::Account.new("bruna_ferraz", "dajhhd")
  #   account.remove_from_watchlist!(23444)
  #
  def remove_from_watchlist!(movie_id)
    toggle_movie_watchlist(movie_id, false)
  end

  # Return a list of account's favorite movies.
  # The returned movies are wrapped into a Enceladus::MovieCollection.
  # Example:
  #
  #   account = Enceladus::Account.new("belinha", "dajhhd")
  #   account.favorite_movies
  #
  def favorite_movies
    Enceladus::MovieCollection.new("account/#{id}/favorite/movies", { session_id: session_id }) if authenticated?
  end

  # Return a list of account's rated movies.
  # The returned movies are wrapped into a Enceladus::MovieCollection.
  # Example:
  #
  #   account = Enceladus::Account.new("belinha", "dajhhd")
  #   account.rated_movies
  #
  def rated_movies
    Enceladus::MovieCollection.new("account/#{id}/rated/movies", { session_id: session_id }) if authenticated?
  end

  # Return the account's watchlist
  # The returned movies are wrapped into a Enceladus::MovieCollection.
  # Example:
  #
  #   account = Enceladus::Account.new("belinha", "hjgsss")
  #   account.watchlist
  #
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