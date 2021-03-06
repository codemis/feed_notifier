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

# parse_notify_spec.rb
#
require 'spec_helper'

RSpec.describe ParseNotify do

    before(:all) do
      parse_settings_file = File.expand_path("../../../settings/parse.yml", __FILE__)
      @parse_settings = YAML.load_file(parse_settings_file)
      @parse_url = @parse_settings['parse']['push_url']
    end

    describe "#send" do

      it "should setup the required Parse request headers" do
        parse_notify = ParseNotify.new(@parse_settings['parse'])
        message = 'New Sermon: Love Zombies'
        stub_post = stub_request(:post, @parse_url).to_return(:body => {'result' =>  true}.to_json)
        parse_notify.send(message)
        assert_requested(:post, @parse_url, :headers => {
          'Content-Type'            =>  'application/json',
          'X-Parse-Application-Id'  =>  @parse_settings['parse']['app_id'],
          'X-Parse-REST-API-Key'    =>  @parse_settings['parse']['rest_api_key']
        }, :times => 1)
      end

      it "should send the correct payload" do
        WebMock.allow_net_connect!
        parse_notify = ParseNotify.new(@parse_settings['parse'])
        message = 'New Sermon: Love Zombies Too'
        stub_post = stub_request(:post, @parse_url).to_return(:body => {'result' =>  true}.to_json)
        parse_notify.send(message)
        assert_requested(:post, @parse_url, :body => {
          'where' =>  {'deviceType'  =>  'ios'},
          'data'  =>  {'alert'  =>  message}
        }.to_json)
      end

      it "should throw an error if Parse sends back a false result" do
        WebMock.allow_net_connect!
        parse_notify = ParseNotify.new(@parse_settings['parse'])
        message = 'New Sermon: I am Broken'
        stub_post = stub_request(:post, @parse_url).to_return(:body => {'result' =>  false}.to_json)
        expect { parse_notify.send(message) }.to raise_error
      end

    end

end