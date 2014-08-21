class RequestTokenResponse
  attr_accessor :expires_at, :request_token, :success

  def initialize
    self.expires_at = "2012-02-09 19:50:25 UTC"
    self.request_token = "641bf16c663db167c6cffcdff41126039d4445bf"
    self.success = true
  end

  def to_hash
    {
      expires_at: expires_at,
      request_token: request_token,
      success: success
    }
  end

  def to_json
    to_hash.to_json
  end
end