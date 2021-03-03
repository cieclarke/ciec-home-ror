require "test_helper"

class NewTest < ActiveSupport::TestCase
   test "json" do
    fs = FlickrService.new(
         Rails.configuration.flickr['uri'],
         Rails.configuration.flickr['api'],
         Rails.configuration.flickr['user']
    )
     puts fs.get_albums
     assert true
   end
end