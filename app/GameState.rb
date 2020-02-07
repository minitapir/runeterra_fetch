class GameState
    attr_accessor :cards

    # {"CardID":828414675,"CardCode":"face","TopLeftX":239,"TopLeftY":641,"Width":156,"Height":156,"LocalPlayer":true}]}
    def initialize(cards)
        @cards = cards
    end

    def ==(other)
        @cards.map{|card| other.cards.include?(card)}.reduce(&:&)
    end

    def to_output
        @cards.map do |card|
            card.to_output
        end
    end
end