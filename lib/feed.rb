require 'feedjira'
# Utilities for getting information about feeds
#
class Feed

  # Initialize the class
  #
  def initialize(feed_url)
    @feed = Feedjira::Feed.parse open(feed_url).read
  end

  # Check if there is a new podcast after the given DateTime
  #
  def has_new?(date_time)
    has_new = false
    @feed.entries.each do |entry|
      has_new = true if entry.published.to_date > date_time
    end
    has_new
  end

  # Get the latest entry
  #
  def latest_entry
    @feed.entries.sort_by { |k| !k["published"] }.first
  end

end