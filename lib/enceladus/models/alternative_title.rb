# This class represents alternative titles of movies or TV shows.
class Enceladus::AlternativeTitle < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:iso_3166_1, :title].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES
end
