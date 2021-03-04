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

        if res.is_a?(Net::HTTPSuccess)
            json = JSON.parse(res.body)
            json['photosets']['photoset'].each do |album|
                a = Album.new
                a.id = album['id']
                a.title = album['title']
                a.description = album['description']
                albums.append(a)
            end
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

        if res.is_a?(Net::HTTPSuccess)
            json = JSON.parse(res.body)
            
            json['photoset']['photo'].each do |photo|
                p = Photo.new
                p.id = photo['id']
                p.title = photo['title']
                p.size_urls = {'url_sq' => photo['url_sq'], 'url_m' => photo['url_m']}
                p.uploaded = photo['dateupload']
                photos.append(p)
            end
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

        if res.is_a?(Net::HTTPSuccess)
            json = JSON.parse(res.body)

            json['photos']['photo'].each do |photo|
                p = Photo.new
                p.id = photo['id']
                p.title = photo['title']
                p.size_urls = { 'url_sq' => photo['url_sq'], 'url_m' => photo['url_m'] }
                p.uploaded = photo['dateupload']
                photos.append(p)
            end
        end

        if photos.length <= count.to_i
            photos
        else
            photos[0..count.to_i-1]
        end

    end
    
end
