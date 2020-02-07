require_relative './GameCard'

class Game
    attr_accessor :player, :opponent, :cards

    def initialize(player, opponent) 
        @player = player
        @opponent = opponent
        @cards = []
    end

    def ==(other)
        @player == other.player &&
        @opponent == other.opponent 
    end
end