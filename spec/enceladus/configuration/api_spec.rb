require 'spec_helper'

describe Enceladus::Configuration::Api do

  around do |example|
    Singleton.__init__(Enceladus::Configuration::Api)
    example.run
    Singleton.__init__(Enceladus::Configuration::Api)
  end

  describe "#connect" do
    subject { Enceladus::Configuration::Api.instance.connect(api_key) }
    let(:api_key) { "token" }
    let(:error_response) { build(:error_response) }

    context "when the provided api_key is not valid" do
      before do
        stub_request(:get, /api.themoviedb.org\/3\/configuration/).
          to_return(status: 401, body: error_response.to_json)
      end

      it "should set Enceladus::Configuration::Api api_key as nil" do
        subject
        expect(Enceladus::Configuration::Api.instance.api_key).to be_nil
      end

      it "should call Enceladus::Configuration::Image.instance.reset!" do
        expect(Enceladus::Configuration::Image.instance).to receive(:reset!)
        subject
      end

      it "should return false" do
        should eq(false)
      end
    end

    context "when the provided api_key is valid" do
      let(:configuration_response) { build(:configuration_response) }
      before do
        stub_request(:get, /api.themoviedb.org\/3\/configuration/).
          to_return(status: 200, body: configuration_response.to_json)
      end

      it "should save Enceladus::Configuration::Api api_key" do
        subject
        expect(Enceladus::Configuration::Api.instance.api_key).to eq(api_key)
      end

      it "should return true" do
        should eq(true)
      end
    end
  end

  describe "#url_for" do
    subject { Enceladus::Configuration::Api.instance.url_for(action, params) }
    let(:action) { "movies" }
    let(:params) { { term: "Sasha Grey" } }

    before do
      expect(Enceladus::Configuration::Api.instance).to receive(:api_key).and_return("token")
    end

    it "should return the full endpoint URL based on the provided args" do
      should eq "https://api.themoviedb.org/3/movies?term=Sasha+Grey&api_key=token"
    end
  end
end
