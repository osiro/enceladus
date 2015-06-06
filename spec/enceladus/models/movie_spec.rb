require 'spec_helper'

describe Enceladus::Movie do

  before do
    stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: build(:configuration_response).to_json)
    Enceladus.connect("token") # start configuration with default values
  end

  describe "#find" do
    subject(:movie) { Enceladus::Movie.find(movie_response.id) }
    let(:movie_response) { build(:movie_response) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/#{movie_response.id}/).
        to_return(status: 200, body: movie_response.to_json)
    end

    it "should set the attribute adult" do
      expect(movie.adult).to eq(movie_response.adult)
    end

    it "should set the attribute adult" do
      expect(movie.adult).to eq(movie_response.adult)
    end

    it "should set the attribute backdrop_path" do
      expect(movie.backdrop_path).to eq(movie_response.backdrop_path)
    end

    it "should set the attribute belongs_to_collection" do
      expect(movie.belongs_to_collection).to eq(movie_response.belongs_to_collection)
    end

    it "should set the attribute budget" do
      expect(movie.budget).to eq(movie_response.budget)
    end

    it "should set the attribute homepage" do
      expect(movie.homepage).to eq(movie_response.homepage)
    end

    it "should set the attribute id" do
      expect(movie.id).to eq(movie_response.id)
    end

    it "should set the attribute imdb_id" do
      expect(movie.imdb_id).to eq(movie_response.imdb_id)
    end

    it "should set the attribute original_title" do
      expect(movie.original_title).to eq(movie_response.original_title)
    end

    it "should set the attribute overview" do
      expect(movie.overview).to eq(movie_response.overview)
    end

    it "should set the attribute popularity" do
      expect(movie.popularity).to eq(movie_response.popularity)
    end

    it "should set the attribute poster_path" do
      expect(movie.poster_path).to eq(movie_response.poster_path)
    end

    it "should set the attribute release_date" do
      expect(movie.release_date).to eq(movie_response.release_date)
    end

    it "should set the attribute revenue" do
      expect(movie.revenue).to eq(movie_response.revenue)
    end

    it "should set the attribute runtime" do
      expect(movie.runtime).to eq(movie_response.runtime)
    end

    it "should set the attribute status" do
      expect(movie.status).to eq(movie_response.status)
    end

    it "should set the attribute tagline" do
      expect(movie.tagline).to eq(movie_response.tagline)
    end

    it "should set the attribute title" do
      expect(movie.title).to eq(movie_response.title)
    end

    it "should set the attribute vote_average" do
      expect(movie.vote_average).to eq(movie_response.vote_average)
    end

    it "should set the attribute vote_count" do
      expect(movie.vote_count).to eq(movie_response.vote_count)
    end

    describe "#genres" do
      subject { movie.genres }
      let(:genre) { movie.genres.first }
      let(:genre_from_response) { movie_response.genres.first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute id" do
        expect(genre.id).to eq(genre_from_response.id)
      end

      it "should set the attribute name" do
        expect(genre.name).to eq(genre_from_response.name)
      end
    end

    describe "#production_companies" do
      subject { movie.production_companies }
      let(:production_company) { movie.production_companies.first }
      let(:production_company_from_response) { movie_response.production_companies.first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute id" do
        expect(production_company.id).to eq(production_company_from_response.id)
      end

      it "should set the attribute name" do
        expect(production_company.name).to eq(production_company_from_response.name)
      end
    end

    describe "#production_countries" do
      subject { movie.production_countries }
      let(:production_country) { movie.production_countries.first }
      let(:production_country_from_response) { movie_response.production_countries.first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute iso_3166_1" do
        expect(production_country.iso_3166_1).to eq(production_country_from_response.iso_3166_1)
      end

      it "should set the attribute name" do
        expect(production_country.name).to eq(production_country_from_response.name)
      end
    end

    describe "#spoken_languages" do
      subject { movie.spoken_languages }
      let(:spoken_language) { movie.spoken_languages.first }
      let(:spoken_language_from_response) { movie_response.spoken_languages.first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute iso_639_1" do
        expect(spoken_language.iso_639_1).to eq(spoken_language_from_response.iso_639_1)
      end

      it "should set the attribute name" do
        expect(spoken_language.name).to eq(spoken_language_from_response.name)
      end
    end

    describe "#releases" do
      subject { movie.releases }
      let(:release) { movie.releases.first }
      let(:release_from_response) { movie_response.releases[:countries].first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute iso_3166_1" do
        expect(release.iso_3166_1).to eq(release_from_response.iso_3166_1)
      end

      it "should set the attribute certification" do
        expect(release.certification).to eq(release_from_response.certification)
      end

      it "should set the attribute release_date" do
        expect(release.release_date).to eq(release_from_response.release_date)
      end
    end

    describe "#youtube_trailers" do
      subject { movie.youtube_trailers }
      let(:youtube_trailer) { movie.youtube_trailers.first }
      let(:youtube_trailer_from_response) { movie_response.trailers[:youtube].first }

      it { is_expected.to be_kind_of Array }

      it "should set the attribute name" do
        expect(youtube_trailer.name).to eq(youtube_trailer_from_response.name)
      end

      it "should set the attribute size" do
        expect(youtube_trailer.size).to eq(youtube_trailer_from_response.size)
      end

      it "should set the attribute source" do
        expect(youtube_trailer.source).to eq(youtube_trailer_from_response.source)
      end

      it "should set the attribute type" do
        expect(youtube_trailer.type).to eq(youtube_trailer_from_response.type)
      end
    end
  end

  [:upcoming, :now_playing, :popular, :top_rated].each do |endpoint|
    describe ".#{endpoint}" do
      subject(:movies) { Enceladus::Movie.send(endpoint) }
      let(:response) { build(:movie_collection_response) }

      before do
        stub_request(:get, /api.themoviedb.org\/3\/movie\/#{endpoint}/).to_return(status: 200, body: response.to_json)
      end

      it "should return a Enceladus::MovieCollection" do
        is_expected.to be_kind_of(Enceladus::MovieCollection)
      end

      it "should fetch #{endpoint} movies" do
        movie = response.results.first
        expect(movies.all.map(&:id)).to include movie.id
      end
    end
  end

  describe "#similar" do
    subject(:movies) { movie.similar }
    let(:response) { build(:movie_collection_response) }
    let(:movie) { Enceladus::Movie.new }

    before do
      movie.id = 123
      stub_request(:get, /api.themoviedb.org\/3\/movie\/#{movie.id}\/similar/).to_return(status: 200, body: response.to_json)
    end

    it "should return a Enceladus::MovieCollection" do
      is_expected.to be_kind_of(Enceladus::MovieCollection)
    end

    it "should fetch similar movies" do
      movie = response.results.first
      expect(movies.all.map(&:id)).to include response.results.first.id
    end
  end

  describe ".find_by_title" do
    subject(:movies) { Enceladus::Movie.find_by_title(title) }
    let(:response) { build(:movie_collection_response) }
    let(:title) { "Banana" }

    before do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=token&append_to_response=releases,trailers&include_adult=false&include_image_language=en&language=en&page=1&query=#{title}")
        .to_return(status: 200, body: response.to_json)
    end

    it "should return a Enceladus::MovieCollection" do
      is_expected.to be_kind_of(Enceladus::MovieCollection)
    end

    it "should fetch movies by title" do
      movie = response.results.first
      expect(movies.all.map(&:id)).to include movie.id
    end
  end

  describe "#reload" do
    subject(:reload) { movie.reload }

    let(:movie) { Enceladus::Movie.new }
    let(:movie_id) { 1234 }
    let(:response) { build(:movie_response, id: movie_id) }

    before do
      movie.id = movie_id
      stub_request(:get, /api.themoviedb.org\/3\/movie\/#{movie_id}/)
        .to_return(status: 200, body: response.to_json)
    end

    it "should return a Enceladus::Movie" do
      is_expected.to be_kind_of(Enceladus::Movie)
    end

    [:adult, :backdrop_path, :belongs_to_collection, :budget, :homepage, :id, :imdb_id, :original_title, :overview, :popularity,
      :poster_path, :release_date, :revenue, :runtime, :status, :tagline, :title, :vote_average, :vote_count].each do |attr|

      it "should fetch the movie##{attr}" do
        reload
        expect(movie.send(attr)).to eq(response.send(attr))
      end
    end

    it "should fetch movie genres" do
      reload
      genre = movie.genres.first
      genre_from_response = response.genres.first

      expect(genre.id).to eq(genre_from_response.id)
      expect(genre.name).to eq(genre_from_response.name)
    end

    it "should fetch movie production companies" do
      reload
      production_company = movie.production_companies.first
      production_company_from_response = response.production_companies.first

      expect(production_company.id).to eq(production_company_from_response.id)
      expect(production_company.name).to eq(production_company_from_response.name)
    end

    it "should fetch movie production countries" do
      reload
      production_country = movie.production_countries.first
      production_country_from_response = response.production_countries.first

      expect(production_country.iso_3166_1).to eq(production_country_from_response.iso_3166_1)
      expect(production_country.name).to eq(production_country_from_response.name)
    end

    it "should fetch movie spoken languages" do
      reload
      spoken_language = movie.spoken_languages.first
      spoken_language_from_response = response.spoken_languages.first

      expect(spoken_language.iso_639_1).to eq(spoken_language_from_response.iso_639_1)
      expect(spoken_language.name).to eq(spoken_language_from_response.name)
    end

    it "should fetch movie releases" do
      reload
      release = movie.releases.first
      release_from_response = response.releases[:countries].first

      expect(release.iso_3166_1).to eq(release_from_response.iso_3166_1)
      expect(release.certification).to eq(release_from_response.certification)
      expect(release.release_date).to eq(release_from_response.release_date)
    end

    it "should fetch movie trailers" do
      reload
      trailer = movie.youtube_trailers.first
      trailer_from_response = response.trailers[:youtube].first

      expect(trailer.name).to eq(trailer_from_response.name)
      expect(trailer.size).to eq(trailer_from_response.size)
      expect(trailer.source).to eq(trailer_from_response.source)
      expect(trailer.type).to eq(trailer_from_response.type)
    end
  end

  describe "#rate!" do
    subject(:make_request) { movie.rate!(account, rating) }
    let(:movie) { Enceladus::Movie.new }
    let(:rating) { 7.3 }

    before { movie.id = 111 }

    context "when rating with permanent account" do
      let(:account) { Enceladus::Account.new(username, password) }

      let(:request_token_response) { build(:request_token_response) }
      let(:authentication_response) { build(:authentication_response) }
      let(:session_response) { build(:session_response) }
      let(:account_response) { build(:account_response) }
      let(:username) { "ashlynn_brooke" }
      let(:password) { "corinthians" }

      before do
        stub_request(:get, "https://api.themoviedb.org/3/authentication/token/new?api_key=token").
          to_return(status: 200, body: request_token_response.to_json)

        stub_request(:get, "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=token&password=#{password}&request_token=#{request_token_response.request_token}&username=#{username}").
          to_return(status: 200, body: authentication_response.to_json)

        stub_request(:get, "https://api.themoviedb.org/3/authentication/session/new?api_key=token&request_token=#{request_token_response.request_token}").
          to_return(status: 200, body: session_response.to_json)

        stub_request(:get, "https://api.themoviedb.org/3/account?api_key=token&session_id=#{session_response.session_id}").
          to_return(status: 200, body: account_response.to_json)
      end

      it "should post a request to favorite movie" do
        request = stub_request(:post, "https://api.themoviedb.org/3/movie/#{movie.id}/rating?api_key=token&session_id=#{session_response.session_id}").
          with(body: "{\"value\":7.5}").
          to_return(status: 200, body: "{ \"success\": 1 }")
        make_request
        expect(request).to have_been_requested
      end
    end

    context "when rating with guest account" do
      let(:account) { Enceladus::GuestAccount.new }
      let(:guest_account_response) { build(:guest_account_response) }

      before do
        stub_request(:get, "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=token").
          to_return(status: 200, body: guest_account_response.to_json)
      end

      it "should post a request to favorite movie" do
        request = stub_request(:post, "https://api.themoviedb.org/3/movie/#{movie.id}/rating?api_key=token&guest_session_id=#{guest_account_response.guest_session_id}").
          with(body: "{\"value\":7.5}").
          to_return(status: 200, body: "{ \"success\": 1 }")
        make_request
        expect(request).to have_been_requested
      end
    end

    context "when provided account is not an Enceladus::Account or Enceladus::GuestAccount" do
      let(:account) { nil }

      it { expect{ subject }.to raise_error(Enceladus::Exception::ArgumentError) }
    end
  end

  describe "#cast" do
    subject(:cast) { movie.cast }
    let(:movie) { Enceladus::Movie.new }
    let(:movie_id) { 123 }
    let(:response) { build(:credits_collection_response) }
    let(:cast_response) { response.cast.first }

    before do
      movie.id = movie_id
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=token").
        to_return(status: 200, body: response.to_json)
    end

    it "should return an array of Enceladus::Cast" do
      expect(cast.map(&:class)).to eq([Enceladus::Cast])
    end

    describe "single cast resource" do
      subject { cast.first }

      [:cast_id, :character, :credit_id, :id, :name, :order, :profile_path].each do |attr|
        it "should set cast #{attr}" do
          expect(subject.send(attr)).to eq(cast_response.send(attr))
        end
      end
    end
  end

  describe "#backdrop_urls" do
    subject { movie.backdrop_urls }
    let(:movie) { Enceladus::Movie.new }

    before do
      movie.backdrop_path = "/pamela_butt.jpeg"
    end

    it "should return profile url" do
      is_expected.to eq(["http://test.com/w300#{movie.backdrop_path}", "http://test.com/w780#{movie.backdrop_path}", "http://test.com/w1280#{movie.backdrop_path}", "http://test.com/original#{movie.backdrop_path}"])
    end
  end

  describe "#poster_urls" do
    subject { movie.poster_urls }
    let(:movie) { Enceladus::Movie.new }

    before do
      movie.poster_path = "/vivi_fernandes.jpeg"
    end

    it "should return profile url" do
      is_expected.to eq(["http://test.com/w92#{movie.poster_path}", "http://test.com/w154#{movie.poster_path}", "http://test.com/w185#{movie.poster_path}", "http://test.com/w342#{movie.poster_path}", "http://test.com/w500#{movie.poster_path}", "http://test.com/w780#{movie.poster_path}", "http://test.com/original#{movie.poster_path}"])
    end
  end
end