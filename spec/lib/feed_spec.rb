# This file is part of Feed Notifier.
# 
# Upload Test Files is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Feed Notifier is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see 
# <http://www.gnu.org/licenses/>.
# 
# @author Johnathan Pulos <johnathan@missionaldigerati.org>
# @license http://opensource.org/licenses/gpl-license.php GNU Public License

# feed_spec.rb
#
require 'spec_helper'

RSpec.describe Feed do

  before(:all) do
    @podcast_url = File.expand_path("../../sample_feeds/podcast.xml", __FILE__)
    @blog_url = File.expand_path("../../sample_feeds/blog.xml", __FILE__)
  end

  describe "#has_new?" do

    it "should return true if there is a new podcast later than the date given" do
      podcast = Feed.new(@podcast_url)
      has_new = podcast.has_new?(DateTime.parse('2001-02-03T18:41:52-07:00'))
      expect(has_new).to eq(true)
    end

    it "should return false if there is not a new podcast later than the date given" do
      podcast = Feed.new(@podcast_url)
      has_new = podcast.has_new?(DateTime.parse('2014-05-12T18:41:52-07:00'))
      expect(has_new).to eq(false)
    end

    it "should return true if there is a new blog post later than the date given" do
      blog = Feed.new(@blog_url)
      has_new = blog.has_new?(DateTime.parse('2001-02-03T18:41:52-07:00'))
      expect(has_new).to eq(true)
    end

    it "should return false if there is not a new blog post later than the date given" do
      blog = Feed.new(@blog_url)
      has_new = blog.has_new?(DateTime.parse('2014-05-15T18:41:52-07:00'))
      expect(has_new).to eq(false)
    end

  end

  describe "#latest_entry" do

    it "should return the latest podcast" do
      podcast = Feed.new(@podcast_url)
      latest = podcast.latest_entry
      expect(latest.title).to eq('John 1:29')
      expect(latest.itunes_author).to eq('Director of Student Ministries - Geoff Smith')
      expect(latest.enclosure_url).to eq('http://sgucandcs.org/podcast_item/38/286/2014.5.11.mp3')
    end

    it "should return the latest blog post" do
      blog = Feed.new(@blog_url)
      latest = blog.latest_entry
      expect(latest.title).to eq('Feed Your Heart. Feed It! (Scottish Accent)')
      expect(latest.author).to eq('Geoff Smith')
      expect(latest.url).to eq('http://www.sgucblog.com/2014/05/14/feed-your-heart-feed-it-scottish-accent/')
    end

  end

end