require 'spec_helper'

describe Enceladus do

  describe ".connect" do
    subject { Enceladus.connect(api_key) }
    let(:api_key) { "token" }
    let(:configuration) { build(:configuration_response) }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: configuration.to_json)
    end

    it "should start the configuration workflow" do
      expect(Enceladus::Configuration::Api.instance).to receive(:connect).with(api_key)
      subject
    end

    it "should set Enceladus::Configuration::Image#include_image_language as English" do
      subject
      expect(Enceladus::Configuration::Image.instance.include_image_language).to eq("en")
    end

    it "should set Enceladus::Configuration::Api#include_adult as false" do
      subject
      expect(Enceladus::Configuration::Api.instance.include_adult).to eq(false)
    end

    describe "include_image_language" do
      context "when include_image_language is provided" do
        subject { Enceladus.connect(api_key, { include_image_language: include_image_language } ) }
        let(:include_image_language) { "pt-BR" }

        it "should set Enceladus::Configuration::Image#include_image_language properly" do
          subject
          expect(Enceladus::Configuration::Image.instance.include_image_language).to eq(include_image_language)
        end
      end
    end

    describe "include_adult" do
      context "when include_adult is provided" do
        subject { Enceladus.connect(api_key, { include_adult: true }) }
        let(:include_adult) { true }

        it "should set Enceladus::Configuration::Api#include_adult properly" do
          subject
          expect(Enceladus::Configuration::Api.instance.include_adult).to eq(include_adult)
        end
      end
    end
  end
end