require '../app/LORFetch'
require 'rest-client'

RSpec.describe LORFetch do

    let(:response){ LORFetch.fetch }

    context "when the game is not started" do
        it "fails to fetch data" do
            expect(response).to eq({"GameState" => "Offline"})
        end
    end

    context "when the game is started" do
        context "when not in a game" do
            before do 
                allow(RestClient)
                .to receive_message_chain("get.body")
                .with(no_args)
                .and_return('{"PlayerName":null,"OpponentName":null,"GameState":"Menus","Screen":{"ScreenWidth":2560,"ScreenHeight":1440},"Rectangles":[]}')
            end

            it "should return a JSON saying that we're in the menus" do
                expect(response).to include("GameState" => "Menus")
                expect(response).to include("Rectangles" => [])
            end
        end

        context "when in a game" do
            before do 
                allow(RestClient)
                .to receive_message_chain("get.body")
                .with(no_args)
                .and_return('{"PlayerName":"MiniTapir","OpponentName":"Shirek","GameState":"InProgress","Screen":{"ScreenWidth":2560,"ScreenHeight":1440},"Rectangles":[{"CardID":889114000,"CardCode":"face","TopLeftX":239,"TopLeftY":954,"Width":156,"Height":156,"LocalPlayer":false},{"CardID":1295299980,"CardCode":"face","TopLeftX":239,"TopLeftY":641,"Width":156,"Height":156,"LocalPlayer":true}]}')
            end
            
            it "should return a JSON saying that we're in a game" do
                expect(response).to include("GameState" => "InProgress")
                expect(response).to have_key("PlayerName")
                expect(response).to have_key("OpponentName")
            end
            
            it "cards placements should contain valid data" do
                expect(response).to have_key("Rectangles")
                rectangles = response["Rectangles"]
                expect(rectangles.first).to match (a_hash_including(
                    "CardID" => a_kind_of(Integer),
                    "CardCode" => a_kind_of(String),
                    "TopLeftX" => a_kind_of(Integer),
                    "TopLeftY" => a_kind_of(Integer),
                    "Width" => a_kind_of(Integer),
                    "Height" => a_kind_of(Integer)
                ))
            end
        end
    end
end
