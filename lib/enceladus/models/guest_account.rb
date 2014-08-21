class Enceladus::GuestAccount
  attr_reader :session_id

  def initialize
    self.session_id = Enceladus::Requester.get("authentication/guest_session/new").guest_session_id
  end

private
  attr_writer :session_id
end