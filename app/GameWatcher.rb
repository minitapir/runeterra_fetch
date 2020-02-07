require_relative 'LORFetch'
require_relative 'Game'

# When initialied, start to ping every second Runeterra
# When the game is launched, status goes from "offline" to "Menus"
class GameWatcher
    attr_accessor :state, :game

    def initialize
        @state = "Offline"
        @game = nil
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
            if(@game == nil)
                create_game(data)
            else
                update_game(data)
            end
        end
    end

    def create_game(data)
        player = data["PlayerName"]
        opponent = data["OpponentName"]
        @game = Game.new(player, opponent)
    end

    def get_data 
        return LORFetch.fetch
    end

    def update_state(state)
        if(@state == "Offline" && state == "Menus")
            puts "Connected to Runeterra."
        elsif(@state == "Menus" && state == "InProgress")
            puts "Entering new game."
        elsif(@state == "InProgress" && state == "Menus")
            puts "Exiting game."
        elsif(@state == "Menus" && state == "Offline")
            puts "Disconnected from Runeterra."
        end
        puts state
        @state = state
    end
end