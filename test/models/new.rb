require "test_helper"

class NewTest < ActiveSupport::TestCase
   test "json" do
    fs = FlickrService.new(
         Rails.configuration.flickr['uri'],
         Rails.configuration.flickr['api'],
         Rails.configuration.flickr['user']
    )
     albums = fs.get_albums
     a =  albums[0]
     #puts fs.get_photos(a).to_json
     assert true
   end

   test "json2" do
      ts = TumblrService.new(
         Rails.configuration.tumblr['uri'],
         Rails.configuration.tumblr['api']
      )
      blogitems = ts.get_items
      puts blogitems
      assert true
   end
end