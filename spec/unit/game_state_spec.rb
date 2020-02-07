require_relative '../../app/GameCard'
require_relative '../../app/GameState'

module LORFetch
    RSpec.describe "GameState" do

        let(:card1){ GameCard.new(1, "face", 200, 200, 200, 200, true) }
        let(:card2){ GameCard.new(2, "face", 200, 200, 200, 200, true) }
        let(:card3){ GameCard.new(3, "face", 200, 200, 200, 200, false) }

        let(:game_state_1) {
            GameState.new([card1, card2])
        }
        let(:game_state_2) {
            GameState.new([card1, card2])
        }
        let(:game_state_3) {
            GameState.new([card2, card3])
        }
        
        it "should return true when comparing two similar GameStates" do
            expect(game_state_1).to eq(game_state_1)
            expect(game_state_1).to eq(game_state_2)
            expect(game_state_2).to eq(game_state_1)
            expect(game_state_2).to eq(game_state_2)
        end

        it "should return false when comparing two different GameStates" do
            expect(game_state_1).not_to eq(game_state_3)
            expect(game_state_2).not_to eq(game_state_3)
            expect(game_state_3).not_to eq(game_state_1)
            expect(game_state_3).not_to eq(game_state_2)
        end
    end
end