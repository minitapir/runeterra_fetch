require 'rest-client'
require 'json'

module LORFetch
    def self.fetch(url="http://localhost:21337/positional-rectangles" )
        begin
            uri = URI(url)
            response = RestClient.get(url)
            return JSON.parse(response.body)
        rescue Errno::EADDRNOTAVAIL, Errno::ECONNREFUSED => e
            return {"GameState" => "Offline"}
        end
    end
end
