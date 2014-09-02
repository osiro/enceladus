class ProductionCompanyResponse
  attr_accessor :description, :headquarters, :homepage, :id, :logo_path, :name, :parent_company

  def initialize
    self.description = "This is a sample description"
    self.headquarters = "San Francisco, California"
    self.homepage = "http://github.com/enceladus"
    self.id = 123
    self.logo_path = "/pic.jpg"
    self.name = "Super Company"
    self.parent_company = "My Parent Company"
  end

  def to_hash
    {
      description: description,
      headquarters: headquarters,
      homepage: homepage,
      id: id,
      logo_path: logo_path,
      name: name,
      parent_company: parent_company,
    }
  end

  def to_json
    to_hash.to_json
  end
end