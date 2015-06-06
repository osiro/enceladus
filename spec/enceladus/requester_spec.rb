require 'spec_helper'

describe Enceladus::Requester do
  # Other requester methods are covered by other tests that fetch TMDb API resources, such as Movies, Cast, Genres, etc.
  describe "response parse error" do
    subject { Enceladus::Requester.get("/movie") }

    describe "malformed response" do
      before do
        stub_request(:get, /api.themoviedb.org\/movie/).to_return(status: 200, body: "")
      end

      it "should raise error Enceladus::Exception::JsonParseError" do
        expect{ subject }.to raise_error Enceladus::Exception::JsonParseError
      end
    end

    describe "SSLCertificateNotVerified" do
      before do
        allow(Enceladus::Requester).to receive(:get) { raise RestClient::SSLCertificateNotVerified, 'test' }
      end

      it "should re-raise the exception RestClient::SSLCertificateNotVerified" do
        expect{ subject }.to raise_error(RestClient::SSLCertificateNotVerified)
      end
    end
  end
end