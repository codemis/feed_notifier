# This file is part of Feed Parse Push Notifier.
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

require 'rest_client'
require 'json'

# Utility for sending a parse notification
#
class ParseNotify

  # Intialize the ParseNotify Class
  #
  def initialize(parse_settings)
    @parse_settings = parse_settings
  end

  # Send a push notification
  # Raises an exception if Parse fails to send back the proper response
  #
  def send(message)
    headers = {
      'Content-Type'            =>  'application/json',
      'X-Parse-Application-Id'  =>  @parse_settings['app_id'],
      'X-Parse-REST-API-Key'    =>  @parse_settings['rest_api_key']
    }
    payload = {
      'where' =>  {'deviceType'  =>  'ios'},
      'data'  =>  {'alert'  =>  message}
    }
    response = RestClient.post(@parse_settings['push_url'], payload.to_json, headers)
    response_json = JSON.parse(response)

    if response_json['result'] === false
      raise Exception.new("Parse did not receive the push notification request.")
    end
  end


end