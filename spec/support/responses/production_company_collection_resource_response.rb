class ProductionCompanyCollectionResourceResponse

  attr_accessor :id, :logo_path, :name

  def initialize
    self.id = 34
    self.logo_path = "/56VlAu08MIE926dQNfBcUwTY8np.png"
    self.name = "Sony Pictures"
  end

  def to_hash
    {
      id: id,
      logo_path: logo_path,
      name: name
    }
  end

  def to_json
    to_hash.to_json
  end
end