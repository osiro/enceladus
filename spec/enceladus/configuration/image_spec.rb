require 'spec_helper'

describe Enceladus::Configuration::Image do
  let(:configuration) { build(:configuration_response) }

  around do |example|
    Singleton.__init__(Enceladus::Configuration::Image)
    example.run
    Singleton.__init__(Enceladus::Configuration::Image)
  end

  describe "#setup!" do
    subject(:image) { Enceladus::Configuration::Image.instance.setup! }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).
        to_return(status: 200, body: configuration.to_json)
    end

    it "should save the base_url" do
      expect(image.base_url).to eq(configuration.base_url)
    end

    it "should save the secure_base_url" do
      expect(image.secure_base_url).to eq(configuration.secure_base_url)
    end

    it "should save the backdrop_sizes" do
      expect(image.backdrop_sizes).to eq(configuration.backdrop_sizes)
    end

    it "should save the logo_sizes" do
      expect(image.logo_sizes).to eq(configuration.logo_sizes)
    end

    it "should save the poster_sizes" do
      expect(image.poster_sizes).to eq(configuration.poster_sizes)
    end

    it "should save the profile_sizes" do
      expect(image.profile_sizes).to eq(configuration.profile_sizes)
    end

    it "should save the still_sizes" do
      expect(image.still_sizes).to eq(configuration.still_sizes)
    end

    it "should return Enceladus::Configuration::Image.instance" do
      is_expected.to eq(Enceladus::Configuration::Image.instance)
    end
  end

  describe "#reset!" do
    subject(:image) { Enceladus::Configuration::Image.instance.reset! }

    it "should nullify the base_url" do
      expect(image.base_url).to be_nil
    end

    it "should nullify the secure_base_url" do
      expect(image.secure_base_url).to be_nil
    end

    it "should set the backdrop_sizes as an empty array" do
      expect(image.backdrop_sizes).to eq([])
    end

    it "should set the logo_sizes as an empty array" do
      expect(image.logo_sizes).to eq([])
    end

    it "should set the poster_sizes as an empty array" do
      expect(image.poster_sizes).to eq([])
    end

    it "should set the profile_sizes as an empty array" do
      expect(image.profile_sizes).to eq([])
    end

    it "should set the still_sizes as an empty array" do
      expect(image.still_sizes).to eq([])
    end

    it "should return Enceladus::Configuration::Image.instance" do
      is_expected.to eq(Enceladus::Configuration::Image.instance)
    end
  end

  describe "#url_for" do
    subject { Enceladus::Configuration::Image.instance.url_for(type, image_path) }
    let(:image_path) { "/asa_akira.jpeg" }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: configuration.to_json)
      Enceladus::Configuration::Image.instance.setup!
    end

    context "when type is backdrop" do
      let(:type) { "backdrop" }

      it "should return an array containing all image URL's of backdrops" do
        is_expected.to eq(["http://test.com/w300/asa_akira.jpeg", "http://test.com/w780/asa_akira.jpeg", "http://test.com/w1280/asa_akira.jpeg", "http://test.com/original/asa_akira.jpeg"])
      end
    end

    context "when type is logo" do
      let(:type) { "logo" }

      it "should return an array containing all image URL's of logos" do
        is_expected.to eq(["http://test.com/w45/asa_akira.jpeg", "http://test.com/w92/asa_akira.jpeg", "http://test.com/w154/asa_akira.jpeg", "http://test.com/w185/asa_akira.jpeg", "http://test.com/w300/asa_akira.jpeg", "http://test.com/w500/asa_akira.jpeg", "http://test.com/original/asa_akira.jpeg"])
      end
    end

    context "when type is poster" do
      let(:type) { "poster" }

      it "should return an array containing all image URL's of logos" do
        is_expected.to eq(["http://test.com/w92/asa_akira.jpeg", "http://test.com/w154/asa_akira.jpeg", "http://test.com/w185/asa_akira.jpeg", "http://test.com/w342/asa_akira.jpeg", "http://test.com/w500/asa_akira.jpeg", "http://test.com/w780/asa_akira.jpeg", "http://test.com/original/asa_akira.jpeg"])
      end
    end

    context "when type is profile" do
      let(:type) { "profile" }

      it "should return an array containing all image URL's of profiles" do
        is_expected.to eq(["http://test.com/w45/asa_akira.jpeg", "http://test.com/w185/asa_akira.jpeg", "http://test.com/h632/asa_akira.jpeg", "http://test.com/original/asa_akira.jpeg"])
      end
    end

    context "when type is invalid" do
      let(:type) { "jenna_jamenson" }

      it "should raise ArgumentError" do
        expect{ subject }.to raise_error(ArgumentError)
      end
    end

    context "when image_path is nil" do
      let(:type) { "profile" }
      let(:image_path) { nil }

      it "should return an empty array" do
        is_expected.to eq([])
      end
    end

    context "when Enceladus::Configuration::Image is invalid" do
      let(:type) { "profile" }

      before { Enceladus::Configuration::Image.instance.reset! }

      it "should return an empty array" do
        is_expected.to eq([])
      end
    end
  end

  describe "#valid?" do
    subject { Enceladus::Configuration::Image.instance.valid? }
    let(:image) { Enceladus::Configuration::Image.instance }

    before do
      stub_request(:get, /api.themoviedb.org\/3\/configuration/).to_return(status: 200, body: configuration.to_json)
      image.setup!
    end

    context "when base_url is nil" do
      before { image.send("base_url=", nil) }
      it { is_expected.to eq(false) }
    end

    context "when secure_base_url is nil" do
      before { image.send("secure_base_url=", nil) }
      it { is_expected.to eq(false) }
    end

    context "when backdrop_sizes is empty" do
      before { image.send("backdrop_sizes=", []) }
      it { is_expected.to eq(false) }
    end

    context "when logo_sizes is empty" do
      before { image.send("logo_sizes=", []) }
      it { is_expected.to eq(false) }
    end

    context "when poster_sizes is empty" do
      before { image.send("poster_sizes=", []) }
      it { is_expected.to eq(false) }
    end

    context "when profile_sizes is empty" do
      before { image.send("profile_sizes=", []) }
      it { is_expected.to eq(false) }
    end

    context "when still_sizes is empty" do
      before { image.send("still_sizes=", []) }
      it { is_expected.to eq(false) }
    end

    context "when none of the configuration options are nil or empty" do
      it { is_expected.to eq(true) }
    end
  end
end