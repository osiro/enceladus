class Enceladus::GuestAccount
  attr_reader :session_id

  # Initiaises a guest account.
  # This method hits the following api endpoint:
  # - https://api.themoviedb.org/3/authentication/guest_session/new
  #
  # For more information about guest accounts, check out http://docs.themoviedb.apiary.io/ SECTION: Authentication
  def initialize
    self.session_id = Enceladus::Requester.get("authentication/guest_session/new").guest_session_id
  end

  # Returns a list of rated movies for a specific guest account.
  # Example:
  #   account = Enceladus::GuestAccount.new
  #   account.rated_movies("desc")
  #   => [Movie, Movie, ..., Movie]
  def rated_movies(order="asc")
    raise Enceladus::Exception::ArgumentError.new("Argument error must be one of: asc or desc") if order != "asc" && order != "desc"
    Enceladus::MovieCollection.new("guest_session/#{session_id}/rated_movies", { sort_by: "created_at", sort_order: order }) if authenticated?
  end

private
  attr_writer :session_id

  def authenticated?
    !session_id.nil?
  end
end