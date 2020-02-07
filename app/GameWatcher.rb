require_relative 'LORFetch'
require_relative 'Game'

# When initialied, start to ping every second Runeterra
# When the game is launched, status goes from "offline" to "Menus"
class GameWatcher
    attr_accessor :state, :game, :verbose

    def initialize
        @state = "Offline"
        @game = nil
        @verbose = false
    end

    def start
        puts "Waiting for Runeterra launch..."
        loop do 
            handle_data(get_data)
            sleep 1
        end
    end

    def handle_data(data)
        update_state(data["GameState"])
        if(@state == "InProgress")
            update_game(data)
        elsif(@state == "Menus" && @game != nil)
            write_game
            @game = nil
        end
    end

    def write_game(filename="result_#{Time.now}.txt")
        File.open("games/#{filename}", "w") { |f| f.write "COUCOU" }
    end

    def update_game(data)
        player = data["PlayerName"]
        opponent = data["OpponentName"]
        cards = data["Rectangles"]
        @game = Game.new(player, opponent, cards)
    end

    def get_data 
        return LORFetch.fetch
    end

    def update_state(state)
        if(verbose)
            if(@state == "Offline" && state != "Offline")
                puts "Connected to Runeterra."
            elsif(@state == "Menus" && state == "InProgress")
                puts "Entering new game."
            elsif(@state == "InProgress" && state == "Menus")
                puts "Exiting game."
            elsif(@state == "Menus" && state == "Offline")
                puts "Disconnected from Runeterra."
            end
            # puts state
        end
        @state = state
    end
end