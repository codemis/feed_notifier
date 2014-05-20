# podcast_spec.rb
#
require 'spec_helper'

RSpec.describe Podcast do

  before(:all) do
    @podcast_url = File.expand_path("../../sample_feeds/podcast.xml", __FILE__)
  end

  describe "#has_new?" do

    it "returns true if there is a new podcast later than the date given" do
      podcast = Podcast.new(@podcast_url)
      has_new = podcast.has_new?(Date.parse('2001-02-03'))
      expect(has_new).to eq(true)
    end

    it "returns false if there is not a new podcast later than the date given" do
      podcast = Podcast.new(@podcast_url)
      has_new = podcast.has_new?(Date.parse('2014-05-12'))
      expect(has_new).to eq(false)
    end

    it "should throw an error if a Date is not passed" do
      podcast = Podcast.new(@podcast_url)
      expect { podcast.has_new?('2014-05-12') }.to raise_error(ArgumentError)
    end
  end
end