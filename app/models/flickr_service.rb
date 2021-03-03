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
        params = {
            method: 'flickr.photosets.getList',
            primary_photo_extras: 'url_m',
            user_id: @user,
            api_key: @api,
            per_page: 10,
            format: 'json',
            nojsoncallback: 1
        }

        flickr_uri.query = URI.encode_www_form(params)

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

    def get_photos(album)

        photos = []
        flickr_uri = URI(@uri)
        params = {
            method: 'flickr.photosets.getPhotos',
            extras: 'tags,url_sq,url_t,url_s,url_m,date_upload',
            user_id: @user,
            api_key: @api,
            photoset_id: album.id,
            format: 'json',
            nojsoncallback: 1
        }

        flickr_uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(flickr_uri)
        json = JSON.parse(res.body)
        
        for photo in json['photoset']['photo']
            p = Photo.new
            p.id = photo['id']
            p.title = photo['title']
            p.size_urls = {'url_sq' => photo['url_sq'], 'url_m' => photo['url_m']}
            p.uploaded = photo['dateupload']
            photos.append(p)
        end

        photos
    end

    def get_recent_photos(count)
        photos = []
        flickr_uri = URI(@uri)
        params = {
            method: 'flickr.people.getPublicPhotos',
            extras: 'tags,url_sq,url_t,url_s,url_m,date_upload',
            user_id: @user,
            api_key: @api,
            count: count,
            format: 'json',
            include_self: 1,
            nojsoncallback: 1
        }

        flickr_uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(flickr_uri)
        json = JSON.parse(res.body)

        for photo in json['photos']['photo']
            p = Photo.new
            p.id = photo['id']
            p.title = photo['title']
            p.size_urls = {'url_sq' => photo['url_sq'], 'url_m' => photo['url_m']}
            p.uploaded = photo['dateupload']
            photos.append(p)
        end

        photos[0..2]

    end
end
