class MovieCollectionResponse < CollectionResponse
  def initialize
    self.results = [MovieCollectionResourceResponse.new]
    super
  end
end