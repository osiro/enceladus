class GuestAccountResponse
  attr_accessor :guest_session_id, :success, :expires_at

  def initialize
    self.guest_session_id = "0c550fd5da2fc3f321ab3bs9b60ca108"
    self.success = true
    self.expires_at = "2012-12-04 22:51:19 UTC"
  end

  def to_hash
    {
      success: success,
      guest_session_id: guest_session_id,
      expires_at: expires_at
    }
  end

  def to_json
    to_hash.to_json
  end
end