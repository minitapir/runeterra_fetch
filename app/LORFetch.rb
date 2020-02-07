require 'rest-client'
require 'json'

module LORFetch
    def self.fetch(url="http://localhost:21337/positional-rectangles" )
        begin
            uri = URI(url)
            puts uri
            response = RestClient.get(url)
            return response.parsed_response
        rescue Errno::EADDRNOTAVAIL => e
            return {"GameState" => e.message}
        end
    end
end
