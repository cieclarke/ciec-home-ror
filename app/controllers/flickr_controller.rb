class FlickrController < ApplicationController

    def albums

        fs = FlickrService.new(
            Rails.configuration.flickr['uri'],
            Rails.configuration.flickr['api'],
            Rails.configuration.flickr['user']
            )
        render json: fs.get_albums

    end

    def photos
        fs = FlickrService.new(
            Rails.configuration.flickr['uri'],
            Rails.configuration.flickr['api'],
            Rails.configuration.flickr['user']
            )
            a = Album.new
            a.id = params[:albumid]
    
        render json: fs.get_photos(a)
    end

    def recentphotos
        fs = FlickrService.new(
            Rails.configuration.flickr['uri'],
            Rails.configuration.flickr['api'],
            Rails.configuration.flickr['user']
            )
    
        render json: fs.get_recent_photos(params[:count])
    end

    def tags

    end

end
