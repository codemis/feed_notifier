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

# last_update_spec.rb
#
require 'spec_helper'
require 'yaml'

RSpec.describe LastUpdate do

  before(:all) do
    @last_update_file = File.expand_path("../../support/last_update.yml", __FILE__)
  end

  describe "#save" do

    it "should save the last update for a blog to a YAML file" do
      last_update = LastUpdate.new(@last_update_file)
      expected_date = DateTime.now
      last_update.save('blog', expected_date)
      contents = YAML.load_file(@last_update_file)
      expect(contents['last_update']['blog']['date']).to eq(expected_date.to_s)
    end

    it "should save the last update for a podcast to a YAML file" do
      last_update = LastUpdate.new(@last_update_file)
      expected_date = DateTime.now
      last_update.save('podcast', expected_date)
      contents = YAML.load_file(@last_update_file)
      expect(contents['last_update']['podcast']['date']).to eq(expected_date.to_s)
    end

  end

  describe "#find" do

    it "should return the last update date for a blog post" do
      contents = YAML.load_file(@last_update_file)
      expected_date = DateTime.parse(contents['last_update']['blog']['date'])
      last_update = LastUpdate.new(@last_update_file)
      expect(last_update.find('blog')).to eq(expected_date)
    end

    it "should return the last update date for a podcast" do
      contents = YAML.load_file(@last_update_file)
      expected_date = DateTime.parse(contents['last_update']['podcast']['date'])
      last_update = LastUpdate.new(@last_update_file)
      expect(last_update.find('podcast')).to eq(expected_date)
    end

  end

end