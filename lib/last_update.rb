require 'yaml'

# Utility for saving and retrieving the last updated date time in a YAML file
#
class LastUpdate

  def initialize(config_file)
    @config_file = config_file
  end

  # read and save the date time to the configuration file
  #
  def save(key, date_time)
    contents = YAML.load_file(@config_file)
    contents['last_update'][key]['date'] = date_time.to_s
    File.open(@config_file, 'w') {|f| f.write contents.to_yaml }
  end

  # Gets the last updated date and returns the date time object
  #
  def find(key)
    contents = YAML.load_file(@config_file)
    DateTime.parse(contents['last_update'][key]['date'])
  end

end