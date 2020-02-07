require_relative '../../app/Game'
require_relative '../../app/GameState'
require_relative '../../app/GameCard'

module LORFetch
    RSpec.describe "Game" do
        
        let(:game) { Game.new("Anto", "MiniTapir", false, 200, 200)}

        context "was just created" do
            it "should have an empty GameState array" do
                expect(game.game_states).to be_empty
            end
        end

        it "should have the correct players' names" do
            expect(game.player).to eq("Anto")
            expect(game.opponent).to eq("MiniTapir")
        end

        it "should have the correct screen dimensions" do
            expect(game.screen_width).to eq(200)
            expect(game.screen_height).to eq(200)
        end
        
        let(:data){ JSON.parse('{"PlayerName":"MiniTapir","OpponentName":"Anto","GameState":"InProgress","Screen":{"ScreenWidth":2560,"ScreenHeight":1440},"Rectangles":[{"CardID":828414675,"CardCode":"face","TopLeftX":239,"TopLeftY":641,"Width":156,"Height":156,"LocalPlayer":true}]}') }
        let(:card) { GameCard.new(828414675,"face", 239, 641, 156, 156, true) }
        let(:game_state) { GameState.new([card]) }

        it "should transform correctly data received into GameState" do 
            gs = Game.to_game_state(data["Rectangles"])
            expect(gs).to eq(game_state)
        end

        context "when a new GameState arrives" do
            it "should correctly detect that the state is new" do
                expect(game.is_new?(game_state)).to eq(true)
            end

            it "should add the state to the array of states" do
                allow(game).to receive(:is_new?).and_return(true)
                game.add_state(game_state)
                expect(game.game_states.size).to eq(1)
                expect(game.game_states.first).to eq(game_state)
            end
        end

        context "when the same GameState arrives" do
            let(:game_state) { GameState.new([]) }
            it "should correctly detect that the state is not new" do
                expect(game.is_new?(game_state)).to eq(false)
            end

            it "shouldn't add the state to the array of states" do
                allow(game).to receive(:is_new?).and_return(false)
                game.add_state(game_state)
                expect(game.game_states.size).to eq(0)
            end
        end
    end
end