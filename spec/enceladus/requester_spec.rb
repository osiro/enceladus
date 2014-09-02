require 'spec_helper'

describe Enceladus::Requester do
  # Other requester methods are covered by other tests that fetch TMDb API resources, such as Movies, Cast, Genres, etc.
  describe "response parse error" do
    subject { Enceladus::Requester.get("/movie") }

    before do
      stub_request(:get, /api.themoviedb.org\/movie/).to_return(status: 200, body: "")
    end

    it "should raise error Enceladus::Exception::JsonParseError" do
      expect{ subject }.to raise_error Enceladus::Exception::JsonParseError
    end
  end
end