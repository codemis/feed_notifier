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