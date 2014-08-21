class AccountResponse
  attr_accessor :id, :include_adult, :iso_3166_1, :iso_639_1, :name, :username

  def initialize
    self.id = "36"
    self.include_adult = false
    self.iso_3166_1 = "US"
    self.iso_639_1 = "en"
    self.name = "John Doe"
    self.username = "johndoe"
  end

  def to_hash
    {
      id: id,
      include_adult: include_adult,
      iso_3166_1: iso_3166_1,
      iso_639_1: iso_639_1,
      name: name,
      username: username
    }
  end

  def to_json
    to_hash.to_json
  end
end