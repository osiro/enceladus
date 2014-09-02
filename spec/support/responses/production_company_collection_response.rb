class ProductionCompanyCollectionResponse < CollectionResponse
  def initialize
    self.results = [ProductionCompanyCollectionResourceResponse.new]
    super
  end
end