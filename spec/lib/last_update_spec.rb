# feed_spec.rb
#
require 'spec_helper'
require 'yaml'

RSpec.describe LastUpdate do

  before(:all) do
    @last_update_file = File.expand_path("../../support/last_update.yml", __FILE__)
  end

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