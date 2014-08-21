class Enceladus::YouTubeTrailer < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:name, :size, :source, :type].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES

  def link
    URI("https://www.youtube.com/watch?v=#{source}")
  end
end