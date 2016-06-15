require_relative "../connect_four.rb"

describe Game do

	before do
		@game = Game.new("Shero", "Zahra")
	end
	
	describe "#initialize" do
		it "responds to 'board'" do
			expect(@game).to respond_to(:board)
		end

		it "responds to 'players'" do
			expect(@game).to respond_to(:player_1)
			expect(@game).to respond_to(:player_2)
		end
	end
end