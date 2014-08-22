class CreditsCollectionResponse
  attr_accessor :id, :cast

  def initialize
    self.id = 550
    self.cast = [CreditsResponse.new]
  end

  def to_hash
    {
      id: id,
      cast: cast.map(&:to_hash)
    }
  end

  def to_json
    to_hash.to_json
  end
end