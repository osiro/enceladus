require 'spec_helper'

describe Enceladus::Configuration::Image do
  let(:configuration_response) { build(:configuration_response) }
  let(:api_image) { Enceladus::Configuration::Image.instance }

  around do |example|
    Singleton.__init__(Enceladus::Configuration::Image)
    example.run
    Singleton.__init__(Enceladus::Configuration::Image)
  end

  before do
    stub_request(:get, /api.themoviedb.org\/3\/configuration/).
      to_return(status: 200, body: configuration_response.to_json)

    api_image.setup!
  end

  
  describe "#url_for" do
    subject(:urls) { api_image.url_for(type, path) }

    let(:path) { "/test.png" }

    ["backdrop", "logo", "poster", "profile"].each do |image_type|
      context "when type is #{image_type}" do
        let(:type) { image_type }

        it "should return an array containing public image paths for #{image_type}" do

          results = api_image.public_send("#{type}_sizes").map do |size|
            "#{api_image.base_url}#{size}#{path}"
          end

          expect(urls).to include *results
        end
      end
    end

    context "when type is invalid" do
      let(:type) { "invalid" }

      it { expect{ subject }.to raise_error ArgumentError }
    end
  end
end
