class Enceladus::ProductionCompany < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:id, :logo_path, :name, :description, :headquarters, :homepage].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES

  # Returns a paginated collection of ProductionCompanies with the name.
  # Example:
  #   Enceladus::ProductionCompany.find_by_name("Marvel")
  #
  def self.find_by_name(name)
    Enceladus::ProductionCompanyCollection.new("search/company", { query: name })
  end

  # Finds a production company by id.
  # Example:
  #   company = Enceladus::ProductionCompany.find(7505)
  def self.find(id)
    build_single_resource(Enceladus::Requester.get("company/#{id}", default_params))
  end

  # Returns an array containing URL's (as string) for the companies logos.
  def logo_urls
    Enceladus::Configuration::Image.instance.url_for("logo", logo_path)
  end

  # Fetchs for more details about the production company.
  # Example:
  #   marvel = Enceladus::ProductionCompany.find_by_name("marvel").last
  #   => #<Enceladus::ProductionCompany @id=325, @logo_path="/pic.png", @name="Marvel Entertainment, LLC">
  #   marvel.reload
  #   => #<Enceladus::ProductionCompan @id=325, @logo_path="/pic.png", @name="Marvel Entertainment, LLC", @description=nil, @headquarters="New York, New York, USA", @homepage="http://www.marvel.com">
  #
  def reload
    rebuild_single_resource(Enceladus::Requester.get("company/#{id}", self.class.default_params))
  end

  # Returns a paginated collection of all movies of a production company.
  # Example:
  #   marvel = Enceladus::ProductionCompany.find(7505)
  #   marvel.movies
  #   => [Movie(@title="Thor"), Movie(@title="Captain America"), Movie(@title="Iron Man")]
  #
  def movies
    Enceladus::MovieCollection.new("company/#{id}/movies", Enceladus::Movie.default_params)
  end

private

  def self.default_params
    language = Enceladus::Configuration::Image.instance.include_image_language
    { append_to_response: "description,headquarters,homepage,id,logo_path,name", language: language }
  end
end