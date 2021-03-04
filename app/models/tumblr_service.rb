require 'net/http'
require 'json'

class TumblrService

    def initialize(uri, api)
        @api, @uri = api, uri
    end

    def get_items
        blogs = []
        tumblr_uri = URI(@uri)

        params = {
            api_key: @api,
            notes_info: 'true',
            filter: 'text'
        }

        tumblr_uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(tumblr_uri)
        
        if res.is_a?(Net::HTTPSuccess)
            json = JSON.parse(res.body)
            json['response']['posts'].each do |item|
                b = BlogItem.new
                b.link = item['url']
                b.id = item['id']
                b.title = item['title']
                b.description = item['description']
                blogs.append(b)
            end
        end

        blogs
    end
end