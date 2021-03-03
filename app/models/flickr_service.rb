require 'net/http'
require 'json'

class FlickrService

    def initialize(uri, api, user)
        @api = api
        @user = user
        @uri = uri
    end

    def get_albums
        albums = []
        flickr_uri = URI(@uri)
        photoset_params = {
            method: 'flickr.photosets.getList',
            primary_photo_extras: 'url_m',
            user_id: @user,
            api_key: @api,
            per_page: 10,
            format: 'json',
            nojsoncallback: 1
        }

        flickr_uri.query = URI.encode_www_form(photoset_params)

        res = Net::HTTP.get_response(flickr_uri)
        json = JSON.parse(res.body)
        for album in json['photosets']['photoset']
            a = Album.new
            a.id = album['id']
            a.title = album['title']
            a.description = album['description']
            albums.append(a)
        end
        albums
    end

end




