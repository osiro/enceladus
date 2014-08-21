class MovieCollectionResourceResponse

  attr_accessor :adult, :backdrop_path, :id, :original_title, :release_date, :poster_path, :popularity, :title, :vote_average, :vote_count

  def initialize
    self.adult = false
    self.backdrop_path = "/tori_black.jpg"
    self.id = 550
    self.original_title = "Original Title"
    self.release_date = "1999-10-14"
    self.poster_path = "belladonna.jpeg"
    self.popularity = 4.5
    self.title = "Title goes here"
    self.vote_average = 5.5
    self.vote_count = 1234
  end

  def to_hash
    {
      adult: adult,
      backdrop_path: backdrop_path,
      id: id,
      original_title: original_title,
      release_date: release_date,
      poster_path: poster_path,
      popularity: popularity,
      title: title,
      vote_average: vote_average,
      vote_count: vote_count
    }
  end

  def to_json
    to_hash.to_json
  end
end