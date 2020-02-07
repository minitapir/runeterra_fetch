require_relative '../../app/GameWatcher'
require_relative '../../app/Game'
require_relative '../../app/LORFetch'

module LORFetch
    RSpec.describe "Runeterra Game Saver" do

        let(:watcher){ GameWatcher.new }

        before do 
            allow(LORFetch)
            .to receive(:fetch)
            .and_return(response)
        end

        context "when I start the program, waiting for a game to start" do

            let(:response) { JSON.parse('{"GameState":"Offline"}') }

            it "GameWatcher should be correctly initialized" do
                expect(watcher.state).to eq "Offline"
                expect(watcher.game).to eq nil
            end

            it "should fetch correct data" do
                expect(watcher.get_data).to eq (response)
            end
            
            it "GameWatcher status should stay 'offline' while game is not launched" do
                watcher.handle_data(response)   
                expect(watcher.state).to eq("Offline")
            end
        end

        context "when the game is launched and not yet in a game" do

            let(:response) { JSON.parse('{"PlayerName":null,"OpponentName":null,"GameState":"Menus","Screen":{"ScreenWidth":2560,"ScreenHeight":1440},"Rectangles":[]}') }

            it "should fetch correct data" do
                expect(watcher.get_data).to eq (response)
            end

            it "should update to the corresponding GameWatcher status" do
                expect{
                    watcher.handle_data(response)   
                }.to change {watcher.state}.to("Menus")
            end
        end

        context "when a game is in progress" do

            let(:response) { JSON.parse('{"PlayerName":"MiniTapir","OpponentName":"Anto","GameState":"InProgress","Screen":{"ScreenWidth":2560,"ScreenHeight":1440},"Rectangles":[{"CardID":828414675,"CardCode":"face","TopLeftX":239,"TopLeftY":641,"Width":156,"Height":156,"LocalPlayer":true}]}') }

            context "and just created" do
                before do 
                    watcher.state = "Menus"
                end

                it "should update to the corresponding GameWatcher status" do
                    expect{
                        watcher.handle_data(response)   
                    }.to change {watcher.state}.from("Menus").to("InProgress")
                end
    
                it "should create a new Game" do
                    watcher.handle_data(response)
                    player = response["PlayerName"]
                    opponent = response["OpponentName"]
                    expect(watcher.game).to eq(Game.new(player, opponent))
                end
            end

            before do 
                watcher.state = "InProgress"
            end

            it "should fetch correct data" do
                expect(watcher.get_data).to eq (response)
            end
        end
    end
end