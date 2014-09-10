require 'spec_helper'

describe Enceladus::Account do

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

  describe "#initialize" do
    subject(:account) { Enceladus::Account.new(username, password) }

    [:id, :include_adult, :iso_3166_1, :iso_639_1, :name, :username].each do |attr|
      it "should set account #{attr}" do
        expect(account.send(attr)).to eq account_response.send(attr)
      end
    end

    it "should set account session_id" do
      expect(account.session_id).to eq session_response.session_id
    end

    it "should nullify account password" do
      expect(account.send(:password)).to be_nil
    end

    it "should nullify account request token" do
      expect(account.send(:request_token)).to be_nil
    end
  end

  describe "#favorite_movie!" do
    subject(:make_request) { account.favorite_movie!(movie_id) }

    let(:account) { Enceladus::Account.new(username, password) }
    let(:movie_id) { 111 }

    it "should post a request to favorite movie" do
      request = stub_request(:post, "https://api.themoviedb.org/3/account/#{account.id}/favorite?api_key=token&session_id=#{session_response.session_id}").
        with(body: "{\"media_type\":\"movie\",\"media_id\":#{movie_id},\"favorite\":true}").
        to_return(status: 200, body: "{ \"success\": 1 }")
      make_request
      expect(request).to have_been_requested
    end
  end

  describe "#unfavorite_movie!" do
    subject(:make_request) { account.unfavorite_movie!(movie_id) }

    let(:account) { Enceladus::Account.new(username, password) }
    let(:movie_id) { 111 }

    it "should post a request to favorite movie" do
      request = stub_request(:post, "https://api.themoviedb.org/3/account/#{account.id}/favorite?api_key=token&session_id=#{session_response.session_id}").
        with(body: "{\"media_type\":\"movie\",\"media_id\":#{movie_id},\"favorite\":false}").
        to_return(status: 200, body: "{ \"success\": 1 }")
      make_request
      expect(request).to have_been_requested
    end
  end

  describe "#add_to_watchlist!" do
    subject(:make_request) { account.add_to_watchlist!(movie_id) }

    let(:account) { Enceladus::Account.new(username, password) }
    let(:movie_id) { 111 }

    it "should post a request to favorite movie" do
      request = stub_request(:post, "https://api.themoviedb.org/3/account/#{account.id}/watchlist?api_key=token&session_id=#{session_response.session_id}").
        with(body: "{\"media_type\":\"movie\",\"media_id\":#{movie_id},\"watchlist\":true}").
        to_return(status: 200, body: "{ \"success\": 1 }")
      make_request
      expect(request).to have_been_requested
    end
  end

  describe "#remove_from_watchlist!" do
    subject(:make_request) { account.remove_from_watchlist!(movie_id) }

    let(:account) { Enceladus::Account.new(username, password) }
    let(:movie_id) { 111 }

    it "should post a request to favorite movie" do
      request = stub_request(:post, "https://api.themoviedb.org/3/account/#{account.id}/watchlist?api_key=token&session_id=#{session_response.session_id}").
        with(body: "{\"media_type\":\"movie\",\"media_id\":#{movie_id},\"watchlist\":false}").
        to_return(status: 200, body: "{ \"success\": 1 }")
      make_request
      expect(request).to have_been_requested
    end
  end

  describe "#favorite_movies" do
    subject(:favorite_movies) { account.favorite_movies }
    let(:account) { Enceladus::Account.new(username, password) }

    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }
    let(:response) { build(:movie_collection_response, results: [movie_1, movie_2]) }

    before do
      stub_request(:get, "https://api.themoviedb.org/3/account/#{account.id}/favorite/movies?api_key=token&page=1&session_id=#{session_response.session_id}").
        to_return(status: 200, body: response.to_json)
    end

    it "should return all favorite movies" do
      expect(favorite_movies.all.map(&:id)).to include *[movie_1.id, movie_2.id]
    end
  end

  describe "#rated_movies" do
    subject(:rated_movies) { account.rated_movies }
    let(:account) { Enceladus::Account.new(username, password) }

    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }
    let(:response) { build(:movie_collection_response, results: [movie_1, movie_2]) }

    before do
      stub_request(:get, "https://api.themoviedb.org/3/account/#{account.id}/rated/movies?api_key=token&page=1&session_id=#{session_response.session_id}").
        to_return(status: 200, body: response.to_json)
    end

    it "should return all rated movies" do
      expect(rated_movies.all.map(&:id)).to include *[movie_1.id, movie_2.id]
    end
  end

  describe "#watchlist" do
    subject(:watchlist) { account.watchlist }
    let(:account) { Enceladus::Account.new(username, password) }

    let(:collection) { Enceladus::MovieCollection.new(path) }
    let(:movie_1) { build(:movie_collection_resource_response) }
    let(:movie_2) { build(:movie_collection_resource_response) }
    let(:response) { build(:movie_collection_response, results: [movie_1, movie_2]) }

    before do
      stub_request(:get, "https://api.themoviedb.org/3/account/#{account.id}/watchlist/movies?api_key=token&page=1&session_id=#{session_response.session_id}").
        to_return(status: 200, body: response.to_json)
    end

    it "should return all rated movies" do
      expect(watchlist.all.map(&:id)).to include *[movie_1.id, movie_2.id]
    end
  end
end