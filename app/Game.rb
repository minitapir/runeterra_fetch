require_relative './GameCard'
require_relative './GameState'

class Game
    attr_accessor :player, :opponent, :game_states

    def initialize(player, opponent) 
        @player = player
        @opponent = opponent
        @game_states = [] 
    end

    # Expecting data["Rectangles"]
    def self.to_game_state(data)
        cards = []
        data.each do |c|
            id = c["CardID"]
            code = c["CardCode"]
            tlx = c["TopLeftX"]
            tly = c["TopLeftY"]
            width = c["Width"]
            height = c["Height"]
            local_player = c["LocalPlayer"]
            add = GameCard.new(id, code, tlx, tly, width, height, local_player)
            cards << add
        end
        return GameState.new(cards)
    end

    def is_new?(state)
        is_new = false
        if(@game_states.size == 0)
            if(state.cards.size != 0)
                is_new = true
            end
        else
            is_new = @game_states.last != state
        end
        return is_new
    end

    def add_state(state)
        @game_states << state if is_new?(state)
    end

    def to_output
        json = {}
        json["PlayerName"] = @player
        json["OpponentName"] = @opponent
        states = []
        @game_states.each do |state|
            states << state.to_output
        end
        json["GameStates"] = states
        json
    end
end