require 'ostruct'
require 'json'

class ApiResponse < OpenStruct
  def as_json
    JSON.parse(to_h.to_json)
  end

  def to_json
    to_h.to_json
  end
end
