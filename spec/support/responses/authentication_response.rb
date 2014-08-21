class AuthenticationResponse
  attr_accessor :request_token, :success

  def initialize
    self.request_token = "641bf16c663db167c6cffcdff41126039d4445bf"
    self.success = true
  end

  def to_hash
    {
      request_token: request_token,
      success: success
    }
  end

  def to_json
    to_hash.to_json
  end
end