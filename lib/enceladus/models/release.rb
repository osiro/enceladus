class Enceladus::Release < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:iso_3166_1, :certification, :release_date].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES
end
