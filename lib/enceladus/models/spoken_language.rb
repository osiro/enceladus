class Enceladus::SpokenLanguage < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:iso_639_1, :name].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES
end