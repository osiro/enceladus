class ErrorResponse
  attr_accessor :status_code, :status_message

  def initialize(code, message)
    self.status_code = code
    self.status_message = message
  end

  def to_json
    { status_code: status_code, status_message: status_message }.to_json
  end
end