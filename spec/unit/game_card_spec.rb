require_relative '../../app/GameCard'

module LORFetch
    RSpec.describe "GameCard" do

        let(:card1){ GameCard.new(828414675,"face", 239, 641, 156, 156, true) }
        let(:card2){ GameCard.new(828414675,"face", 239, 641, 156, 156, true) }
        let(:card3){ GameCard.new(2, "face", 200, 200, 200, 200, false) }

        it "should return true when comparing two similar GameCards" do
            expect(card1).to eq(card2)
            expect(card1).to eq(card1)
            expect(card2).to eq(card2)
            expect(card2).to eq(card1)
        end

        it "should return false when comparing two different GameStates" do
            expect(card2).not_to eq(card3)
            expect(card1).not_to eq(card3)
            expect(card3).not_to eq(card1)
            expect(card3).not_to eq(card2)
        end
    end
end