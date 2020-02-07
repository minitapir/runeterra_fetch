require_relative './GameCard'

class Game
    attr_accessor :player, :opponent, :cards

    def initialize(player, opponent) 
        @player = player
        @opponent = opponent
        @cards = []
    end

    def ==(other)
        equal = self.player == other.player && self.opponent == other.opponent
        if(self.cards.size == other.cards.size)
            if(self.cards == [])
                return true
            else
                equal &= self.cards.map{|card|
                    other.cards.include?(card)
                }.reduce(&:&)
            end
        else
            equal = false
        end
        return equal
    end
end