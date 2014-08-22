class CreditsResponse
  attr_accessor :cast_id, :character, :credit_id, :id, :name, :order, :profile_path

  def initialize
    self.cast_id = 4
    self.character = "The Narrator"
    self.credit_id = "52fe4250c3a36847f80149f3"
    self.id = 819
    self.name = "Edward Norton"
    self.order = 0
    self.profile_path = "/iUiePUAQKN4GY6jorH9m23cbVli.jpg"
  end

  def to_hash
    {
      cast_id: 4,
      character: "The Narrator",
      credit_id: "52fe4250c3a36847f80149f3",
      id: 819,
      name: "Edward Norton",
      order: 0,
      profile_path: "/iUiePUAQKN4GY6jorH9m23cbVli.jpg"
    }
  end

  def to_json
    to_hash.to_json
  end
end