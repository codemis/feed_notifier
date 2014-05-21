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
    raise ArgumentError, "key must be either blog or podcast." unless valid_key?(key)
    raise ArgumentError, "date_time must be a DateTime." unless valid_date_time?(date_time)

    contents = YAML.load_file(@config_file)
    contents['last_update'][key]['date'] = date_time.to_s
    File.open(@config_file, 'w') {|f| f.write contents.to_yaml }
  end

  # Gets the last updated date and returns the date time object
  #
  def datetime(key)
    raise ArgumentError, "key must be either blog or podcast." unless valid_key?(key)
    contents = YAML.load_file(@config_file)
    DateTime.parse(contents['last_update'][key]['date'])
  end

  private
    def valid_key?(key)
      ['blog', 'podcast'].include?(key)
    end

    # Checks if a date is a valid DateTime object
    #
    def valid_date_time?(date_time)
      date_time.is_a?(DateTime)
    end

end