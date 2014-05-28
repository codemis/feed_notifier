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

feeds = { 'blog'      =>  'http://www.sgucblog.com/feed/',
          'podcast'   =>  'http://sgucandcs.org/podcast.php?pageID=38'}

feeds.each do |slug, url|
  puts "Checking URL: #{url}"
  # Check if there is a new blog post
  #
  last_update_datetime = last_update.find(slug)
  feed = Feed.new(URI.parse(url))

  # # Check if there is a new post
  # #
  if feed.has_new?(last_update_datetime)
    puts "We have a new #{slug} entry titled #{feed.latest_entry.title}"
    # Push the new blog entry
    #
    parse_notify.send("New #{slug.capitalize} Entry: #{feed.latest_entry.title}")
    last_update.save(slug, DateTime.now)
  end
end