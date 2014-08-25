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

private
  attr_writer :session_id
end