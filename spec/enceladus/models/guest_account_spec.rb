require 'spec_helper'

describe Enceladus::GuestAccount do

  let(:guest_account_response) { build(:guest_account_response) }

  before do
    stub_request(:get, "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=token").
      to_return(status: 200, body: guest_account_response.to_json)
  end

  describe "#initialize" do
    subject(:account) { Enceladus::GuestAccount.new }

    it "should set account guest_session_id" do
      expect(account.session_id).to eq guest_account_response.guest_session_id
    end
  end

  describe "#rated_movies" do
    subject(:make_request) { account.rated_movies(order) }
    let(:order) { "asc" }
    let(:account) { Enceladus::GuestAccount.new }
    let(:response) { build(:movie_collection_response) }

    it "should return a Enceladus::MovieCollection" do
      stub_request(:get, /api.themoviedb.org\/3\/guest_session\/#{account.session_id}\/rated_movies/).
        to_return(status: 200, body: response.to_json)

      is_expected.to be_kind_of(Enceladus::MovieCollection)
    end

    context "when order is asc" do
      let(:order) { "asc" }
      it "should make a request providing the 'asc' as the sort_order" do
        request = stub_request(:get, "https://api.themoviedb.org/3/guest_session/#{account.session_id}/rated_movies?api_key=token&page=1&sort_by=created_at&sort_order=asc").
          to_return(status: 200, body: response.to_json)

        make_request
        expect(request).to have_been_requested
      end
    end

    context "when order is desc" do
      let(:order) { "desc" }
      it "should make a request providing the 'desc' as the sort_order" do
        request = stub_request(:get, "https://api.themoviedb.org/3/guest_session/#{account.session_id}/rated_movies?api_key=token&page=1&sort_by=created_at&sort_order=desc").
          to_return(status: 200, body: response.to_json)

        make_request
        expect(request).to have_been_requested
      end
    end

    context "when order is invalid" do
      let(:order) { "invalid" }
      it { expect{ subject }.to raise_error Enceladus::Exception::ArgumentError }
    end

    describe "when order is not provided" do
      subject(:make_request) { account.rated_movies }

      it "should make a request providing the 'asc' as the sort_order" do
        request = stub_request(:get, "https://api.themoviedb.org/3/guest_session/#{account.session_id}/rated_movies?api_key=token&page=1&sort_by=created_at&sort_order=asc").
          to_return(status: 200, body: response.to_json)

        make_request
        expect(request).to have_been_requested
      end
    end
  end
end