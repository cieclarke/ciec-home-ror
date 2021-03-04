class TumblrController < ApplicationController

    def links

        ts = TumblrService.new(
            Rails.configuration.tumblr['uri'],
            Rails.configuration.tumblr['api']
            )
        render json: ts.get_items

    end


end
