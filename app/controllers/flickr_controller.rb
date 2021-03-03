require 'net/http'
require 'json'

class FlickrController < ApplicationController
    
    def initialize()
        super()
    end

    def albums
        
        fs = FlickrService.new(
         Rails.configuration.flickr['uri'],
         Rails.configuration.flickr['api'],
         Rails.configuration.flickr['user']
    )
    
    render json: fs.get_albums
     
    end
end
