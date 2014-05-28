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