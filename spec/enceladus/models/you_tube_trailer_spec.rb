require 'spec_helper'

describe Enceladus::YouTubeTrailer do
  describe "#link" do
    subject { youtube_trailer.link }

    let(:youtube_trailer) { Enceladus::YouTubeTrailer.new }
    let(:source) { "dDc5H-WIn6M" }

    before { youtube_trailer.source = source }

    it "should return an instance of URI representing the YouTube video of the trailer" do
      is_expected.to eq(URI("https://www.youtube.com/watch?v=#{source}"))
    end
  end
end