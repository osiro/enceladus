require 'spec_helper'

describe Enceladus::ProductionCompany do
  before do
    stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: build(:configuration_response).to_json)
    Enceladus.connect("token") # start configuration with default values
  end

  describe ".find_by_name" do
    subject(:companies) { Enceladus::ProductionCompany.find_by_name("marvel") }
    let(:collection_response) { build(:production_company_collection_response) }
    let(:company_from_response) { collection_response.results.first }

    before do
      stub_request(:get, "https://api.themoviedb.org/3/search/company?api_key=token&page=1&query=marvel").
        to_return(status: 200, body: collection_response.to_json)
    end

    it "should return a Enceladus::ProductionCompanyCollection" do
      is_expected.to be_kind_of Enceladus::ProductionCompanyCollection
    end

    it "should fetch company details" do
      company = companies.first
      expect(company.id).to eq company_from_response.id
      expect(company.logo_path).to eq company_from_response.logo_path
      expect(company.name).to eq company_from_response.name
    end
  end

  describe ".find" do
    subject(:company) { Enceladus::ProductionCompany.find(123) }
    let(:company_from_response) { build(:production_company_response) }
    before do
      stub_request(:get, "https://api.themoviedb.org/3/company/123?api_key=token&append_to_response=description,headquarters,homepage,id,logo_path,name&language=en").
        to_return(status: 200, body: company_from_response.to_json)
    end

    it "should return Enceladus::ProductionCompany" do
      is_expected.to be_kind_of(Enceladus::ProductionCompany)
    end

    it "should fetch company details" do
      expect(company.description).to eq company_from_response.description
      expect(company.headquarters).to eq company_from_response.headquarters
      expect(company.homepage).to eq company_from_response.homepage
      expect(company.id).to eq company_from_response.id
      expect(company.logo_path).to eq company_from_response.logo_path
      expect(company.name).to eq company_from_response.name
    end
  end

  describe "#logo_urls" do
    subject { company.logo_urls }
    let(:company) { Enceladus::ProductionCompany.new }

    before do
      company.logo_path = "/pic.png"
    end

    it "shold return an array containing the absolute logo urls" do
      is_expected.to include *["http://test.com/w45/pic.png", "http://test.com/w92/pic.png", "http://test.com/w154/pic.png", "http://test.com/w185/pic.png", "http://test.com/w300/pic.png", "http://test.com/w500/pic.png", "http://test.com/original/pic.png"]
    end
  end

  describe "#reload" do
    subject(:reload) { company.reload }
    let(:company) { Enceladus::ProductionCompany.new }
    let(:company_from_response) { build(:production_company_response, id: company.id) }

    before do
      company.id = 123
      stub_request(:get, "https://api.themoviedb.org/3/company/#{company.id}?api_key=token&append_to_response=description,headquarters,homepage,id,logo_path,name&language=en").
        to_return(status: 200, body: company_from_response.to_json)
    end

    it "should fetch company details" do
      reload
      expect(company.description).to eq company_from_response.description
      expect(company.headquarters).to eq company_from_response.headquarters
      expect(company.homepage).to eq company_from_response.homepage
      expect(company.id).to eq company_from_response.id
      expect(company.logo_path).to eq company_from_response.logo_path
      expect(company.name).to eq company_from_response.name
    end
  end

  describe "#movies" do
    subject(:movies) { company.movies }
    let(:company) { Enceladus::ProductionCompany.new }
    let(:response) { build(:movie_collection_response) }
    let(:movie_from_response) { response.results.first }

    before do
      company.id = 123
      stub_request(:get, "https://api.themoviedb.org/3/company/#{company.id}/movies?api_key=token&append_to_response=releases,trailers&include_adult=false&include_image_language=en&language=en&page=1").
        to_return(status: 200, body: response.to_json)
    end

    it "should return a Enceladus::MovieCollection" do
      is_expected.to be_kind_of Enceladus::MovieCollection
    end

    it "should fetch movie details" do
      movie = movies.first
      expect(movie.adult).to eq movie_from_response.adult
      expect(movie.backdrop_path).to eq movie_from_response.backdrop_path
      expect(movie.id).to eq movie_from_response.id
      expect(movie.original_title).to eq movie_from_response.original_title
      expect(movie.release_date).to eq movie_from_response.release_date
      expect(movie.poster_path).to eq movie_from_response.poster_path
      expect(movie.popularity).to eq movie_from_response.popularity
      expect(movie.title).to eq movie_from_response.title
      expect(movie.vote_average).to eq movie_from_response.vote_average
      expect(movie.vote_count).to eq movie_from_response.vote_count
    end
  end
end