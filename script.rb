# require all lib files
#
Dir[File.join(Dir.pwd, 'lib', '*.rb')].each { |f| require f }
# Setup the Parse Settings
#
parse_settings_file = File.expand_path(File.join(Dir.pwd, 'settings', 'parse.yml'), __FILE__)
parse_settings = YAML.load_file(parse_settings_file)

# parse_notify = ParseNotify.new(parse_settings['parse'])
# message = 'New Sermon: Love Zombies Too'
# parse_notify.send(message)