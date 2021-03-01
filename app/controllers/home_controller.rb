class HomeController < ApplicationController
    attr_reader :page_title
    
    def initialize()
        super()
        @page_title = "Home"
    end

    def index
        
    end
end
