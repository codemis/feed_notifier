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

require 'open-uri'

# require all lib files
#
Dir[File.join(Dir.pwd, 'lib', '*.rb')].each { |f| require f }

# Setup the Parse Settings
#
parse_settings_file = File.expand_path(File.join(Dir.pwd, 'settings', 'parse.yml'), __FILE__)
parse_settings = YAML.load_file(parse_settings_file)
parse_notify = ParseNotify.new(parse_settings['parse'])

# Setup the LastUpdate Class
#
last_update_file = File.expand_path(File.join(Dir.pwd, 'settings', 'last_update.yml'), __FILE__)
last_update = LastUpdate.new(last_update_file)

# Grab the feeds to check
#
feeds_file = File.expand_path(File.join(Dir.pwd, 'settings', 'feeds.yml'), __FILE__)
feeds = YAML.load_file(feeds_file)['feeds']

# Check the feeds
#
feeds.each do |slug, url|
  puts "Checking URL: #{url} with a slug: #{slug}"
  last_update_datetime = last_update.find(slug)
  feed = Feed.new(URI.parse(url))

  # Check if there is a new post
  #
  if feed.has_new?(last_update_datetime)
    puts "We have a new #{slug} entry titled #{feed.latest_entry.title}"
    # Push the new blog entry to Parse
    #
    parse_notify.send("New #{slug.capitalize} Entry: #{feed.latest_entry.title}")
    # Update the last update datetime
    #
    last_update.save(slug, DateTime.now)
  end
end