# feed_spec.rb
#
require 'spec_helper'

RSpec.describe Feed do

  before(:all) do
    @podcast_url = File.expand_path("../../sample_feeds/podcast.xml", __FILE__)
    @blog_url = File.expand_path("../../sample_feeds/blog.xml", __FILE__)
  end

  describe "#has_new?" do

    it "should throw an error if a the URL is bad" do
      expect { 
        Feed.new(File.expand_path("../../sample_feeds/fake.xml", __FILE__))
      }.to raise_error(ArgumentError)
    end

    it "returns true if there is a new podcast later than the date given" do
      podcast = Feed.new(@podcast_url)
      has_new = podcast.has_new?(Date.parse('2001-02-03'))
      expect(has_new).to eq(true)
    end

    it "returns false if there is not a new podcast later than the date given" do
      podcast = Feed.new(@podcast_url)
      has_new = podcast.has_new?(Date.parse('2014-05-12'))
      expect(has_new).to eq(false)
    end

    it "returns true if there is a new blog post later than the date given" do
      blog = Feed.new(@blog_url)
      has_new = blog.has_new?(Date.parse('2001-02-03'))
      expect(has_new).to eq(true)
    end

    it "returns false if there is not a new blog post later than the date given" do
      blog = Feed.new(@blog_url)
      has_new = blog.has_new?(Date.parse('2014-05-15'))
      expect(has_new).to eq(false)
    end

    it "should throw an error if a Date is not passed" do
      podcast = Feed.new(@podcast_url)
      expect { podcast.has_new?('2014-05-12') }.to raise_error(ArgumentError)
    end
  end
end