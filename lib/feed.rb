# This file is part of Feed Notifier.
# 
# Upload Test Files is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Joshua Project API is distributed in the hope that it will be useful,
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