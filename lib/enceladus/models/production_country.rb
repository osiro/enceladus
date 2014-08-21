class Enceladus::ProductionCountry < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:iso_3166_1, :name].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES
end
