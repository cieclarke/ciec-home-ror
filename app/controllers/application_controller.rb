class ApplicationController < ActionController::Base
    attr_reader :website_title
    def initialize()
        super()
        @website_title = "cieclarke.com"
    end
    
   
end
