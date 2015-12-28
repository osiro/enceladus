require 'spec_helper'

describe Enceladus do
  it 'has a version number' do
    expect(Enceladus::VERSION).not_to be nil
  end

  describe ".connect" do
    subject { Enceladus.connect(api_key, options) }

    let(:api_key) { "test" }
    let(:options) { {  } }
    let(:configuration_response) { build(:configuration_response) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).
        to_return(status: http_status_code, body: configuration_response.to_json)
    end

    context "when connection succeeds" do
      let(:http_status_code) { 200 }

      it { is_expected.to be_truthy }

      context "when options are not provided" do
        let(:options) { {  } }

        it "should set the image language to 'en'" do
          subject
          expect(Enceladus::Configuration::Image.instance.include_image_language).to eq("en")
        end

        it "should set TMDb API not to return adult content" do
          subject
          expect(Enceladus::Configuration::Api.instance.include_adult).to be_falsey
        end

        it "should set language general content to 'en'" do
          subject
          expect(Enceladus::Configuration::Api.instance.language).to eq("en")
        end
      end

      context "when options are not provided" do
        let(:options) { { include_image_language: "IT", include_adult: true, language: "BR" } }

        it "should set the image language accordingly" do
          subject
          expect(Enceladus::Configuration::Image.instance.include_image_language).to eq(options[:include_image_language])
        end

        it "should set TMDb API to return adult content according to the provided options" do
          subject
          expect(Enceladus::Configuration::Api.instance.include_adult).to eq(options[:include_adult])
        end

        it "should set language general content accordingly" do
          subject
          expect(Enceladus::Configuration::Api.instance.language).to eq(options[:language])
        end
      end
    end

    context "when connection fails" do
      let(:http_status_code) { 422 }
      it { is_expected.to be_falsey }
    end    
  end
end
