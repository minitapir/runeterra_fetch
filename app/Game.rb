require_relative './GameCard'

class Game
    attr_accessor :player, :opponent, :cards

    # {"CardID":828414675,"CardCode":"face","TopLeftX":239,"TopLeftY":641,"Width":156,"Height":156,"LocalPlayer":true}]}
    def initialize(player, opponent, cards) 
        @player = player
        @opponent = opponent
        @cards = []
        set_cards(cards)
        
    end

    def set_cards(cards)
        cards.each do |c|
            id = c["CardId"]
            code = c["CardCode"]
            face = c["face"]
            tlx = c["TopLeftX"]
            tly = c["TopLeftY"]
            width = c["Width"]
            height = c["Height"]
            local_player = c["LocalPlayer"]
            add = GameCard.new id, code, face, tlx, tly, width, height, local_player
            @cards << add
        end
    end

    def ==(other)
        @player == other.player &&
        @opponent == other.opponent && 
        @cards.map{|c| other.cards.include?(c) }.reduce(&:&)  
    end
end