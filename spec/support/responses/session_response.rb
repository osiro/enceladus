class SessionResponse
  attr_accessor :session_id, :success

  def initialize
    self.session_id = "80b2bf99520cd795ff54e31af97917bc9e3a7c8c"
    self.success = true
  end

  def to_hash
    {
      session_id: session_id,
      success: success
    }
  end

  def to_json
    to_hash.to_json
  end
end