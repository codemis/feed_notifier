require 'feedjira'
# Utilities for getting information about a podcast
#
class Feed

  # Initialize the class
  #
  def initialize(feed_url)
    begin
      @feed = Feedjira::Feed.parse open(feed_url).read
    rescue Exception => e
      raise ArgumentError, "The feed URL is invalid."
    end
  end

  # Check if there is a new podcast after the given date
  #
  def has_new?(date)
    raise ArgumentError, "date must be a Date object." unless valid_date?(date)
    has_new = false
    @feed.entries.each do |entry|
      has_new = true if entry.published.to_date > date
    end
    has_new
  end

  # Get the latest entry
  #
  def latest_entry
    @feed.entries.sort_by { |k| !k["published"] }.first
  end

  private

    # Checks if a date is a valid Date object
    #
    def valid_date?(date)
      date.is_a?(Date)
    end

end