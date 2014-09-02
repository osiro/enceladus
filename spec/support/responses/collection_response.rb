class CollectionResponse
  attr_accessor :results, :page, :total_pages, :total_results

  def initialize
    self.page = 1
    self.total_pages = 1
    self.total_results = results.size
  end

  def to_json
    {
      page: page,
      results: results.map(&:to_hash),
      total_pages: total_pages,
      total_results: total_results
    }.to_json
  end
end