require_relative 'LORFetch'
require_relative 'Game'

# When initialied, start to ping every second Runeterra
# When the game is launched, status goes from "offline" to "Menus"
# States = ["Offline", "Menus", "InProgress"]
class GameWatcher
    attr_accessor :state, :game, :verbose

    def initialize(verbose=false)
        @state = "Offline"
        @game = nil
        @verbose = verbose
        puts "Waiting for Runeterra launch..." if verbose
    end

    def start
        loop do 
            handle_data(get_data)
            sleep 1
        end
    end

    def handle_data(data)
        new_state = data["GameState"]

        # A new game just started
        if(@state == "Menus" && new_state == "InProgress")
            create_game(data)
        end

        # End game
        if((@state == "InProgress" && new_state== "Menus") || @state == "InProgress" && new_state== "Offline")
            end_game
        end

        update_state(new_state)

        # Handles states to add 
        if(@state == "InProgress")
            update_game(data["Rectangles"])
        end
    end

    def end_game
        write_game
        @game = nil
    end

    def write_game(filename="result_#{Time.now}.txt")
        File.open("games/#{filename}", "w") { |f| 
            f.write @game.to_output 
        }
    end

    def create_game(data)
        player = data["PlayerName"]
        opponent = data["OpponentName"]
        @game = Game.new(player, opponent)
    end

    def update_game(data)
        game_state = Game.to_game_state(data)
        @game.add_state(game_state)
    end

    def get_data 
        return LORFetch.fetch
    end

    def update_state(state)
        if(@verbose)
            if(@state == "Offline" && state != "Offline")
                puts "Connected to Runeterra."
            elsif(@state == "Menus" && state == "InProgress")
                puts "Entering new game."
            elsif(@state == "InProgress" && state == "Menus")
                puts "Exiting game."
            elsif((@state == "Menus" || @state=="InProgress") && state == "Offline")
                puts "Disconnected from Runeterra."
            end
        end
        @state = state
    end
end