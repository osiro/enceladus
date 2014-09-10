require 'spec_helper'

describe Enceladus::MovieCollection do
  let(:response) { build(:movie_collection_response) }
  let(:path) { "movie/upcoming" }
  let(:params) { { test: 1 } }

  describe ".initialize" do
    subject(:collection) { Enceladus::MovieCollection.new(path, params) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should set path" do
      expect(collection.path).to eq(path)
    end

    it "should set params" do
      expect(collection.params).to eq(params)
    end

    it "should set params[:page] to 1" do
      expect(collection.params[:page]).to eq(1)
    end

    describe "results_per_page" do
      subject(:movies) { collection.results_per_page }
      let(:movie_from_response) { response.results.first }

      it "should contain arrays of Enceladus::Movie" do
        is_expected.to be_kind_of(Array)
        expect(movies.flatten.map(&:class)).to eq([Enceladus::Movie])
      end

      describe "resource" do
        subject(:movie) { movies.flatten.first }

        it "should set adult" do
          expect(movie.adult).to eq(movie_from_response.adult)
        end

        it "should set backdrop_path" do
          expect(movie.backdrop_path).to eq(movie_from_response.backdrop_path)
        end

        it "should set id" do
          expect(movie.id).to eq(movie_from_response.id)
        end

        it "should set original_title" do
          expect(movie.original_title).to eq(movie_from_response.original_title)
        end

        it "should set release_date" do
          expect(movie.release_date).to eq(movie_from_response.release_date)
        end

        it "should set poster_path" do
          expect(movie.poster_path).to eq(movie_from_response.poster_path)
        end

        it "should set popularity" do
          expect(movie.popularity).to eq(movie_from_response.popularity)
        end

        it "should set title" do
          expect(movie.title).to eq(movie_from_response.title)
        end

        it "should set vote_average" do
          expect(movie.vote_average).to eq(movie_from_response.vote_average)
        end

        it "should set vote_count" do
          expect(movie.vote_count).to eq(movie_from_response.vote_count)
        end
      end
    end
  end

  describe "#next_page" do
    subject { collection.next_page  }
    let(:collection) { Enceladus::MovieCollection.new(path) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should increment current_page" do
      subject
      expect(collection.current_page).to eq(2)
    end

    it "should fetch resources and save into results_per_page properly" do
      subject
      expect(collection.results_per_page.map(&:class)).to eq([Array, Array])
    end

    it "should return movies for the current_page" do
      expect(subject.map(&:class)).to include(Enceladus::Movie)
    end
  end

  describe "#previous_page" do
    subject { collection.next_page; collection.previous_page }
    let(:collection) { Enceladus::MovieCollection.new(path) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should decrement current_page" do
      subject
      expect(collection.current_page).to eq(1)
    end

    it "should fetch resources and save into results_per_page properly" do
      subject
      expect(collection.results_per_page.map(&:class)).to eq([Array, Array])
    end

    it "should return movies for the current_page" do
      expect(subject.map(&:class)).to include(Enceladus::Movie)
    end
  end

  describe "#current_page" do
    subject { collection.current_page }
    let(:collection) { Enceladus::MovieCollection.new(path) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    context "when current page is 1" do
      it "should return 1" do
        is_expected.to eq(1)
      end
    end

    context "when current page is 2" do
      before { collection.next_page }
      it "should return 2" do
        is_expected.to eq(2)
      end
    end
  end

  describe "#current_page=" do
    subject { collection.current_page = page }
    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:page) { 10 }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should fetch movies and save into results_per_page properly" do
      expect { subject }.to change{ collection.results_per_page[page - 1] }.from(nil)
    end
  end

  describe "#last" do
    subject { collection.last }
    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }

    before do
      response.results = [movie_1, movie_2]
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should return the last movie" do
      expect(subject.id).to eq(movie_2.id)
    end
  end

  describe "#first" do
    subject { collection.first }
    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }

    before do
      response.results = [movie_1, movie_2]
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should return the first movie" do
      expect(subject.id).to eq(movie_1.id)
    end
  end

  describe "#all" do
    subject { collection.all }
    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }

    before do
      response.results = [movie_1, movie_2]
      stub_request(:get, /api.themoviedb.org\/3\/movie\/upcoming/).to_return(status: 200, body: response.to_json)
    end

    it "should return all movies of the current page" do
      expect(subject.map(&:id)).to include *[movie_1.id, movie_2.id]
    end
  end
end