require 'spec_helper'

describe Enceladus::Cast do
  describe "#profile_urls" do
    subject { cast.profile_urls }
    let(:cast) { Enceladus::Cast.new }

    before do
      cast.profile_path = "/aylar_lie.jpeg"
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: build(:configuration_response).to_json)
      Enceladus::Configuration::Image.instance.setup!
    end

    it "should return profile url" do
      is_expected.to eq(["http://test.com/w45#{cast.profile_path}", "http://test.com/w185#{cast.profile_path}", "http://test.com/h632#{cast.profile_path}", "http://test.com/original#{cast.profile_path}"])
    end
  end
end