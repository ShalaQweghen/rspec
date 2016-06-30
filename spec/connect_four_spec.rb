require_relative "../connect_four.rb"

describe Game do

	before do
		@game = Game.new
	end

	describe "#start" do
		it "gives a welcome message" do
			expect { @game.start }.to output("              WELCOME TO CONNECT FOUR!           "\
         								     "\n\n================================================="\
        								     "\nThis is a game where you will try to connect four"\
         								     "\nof your tiles before your opponent. They can be  "\
        								     "\nconnected vertically, horizontally or diagonally."\
        								     "\n\n                    GOOD LUCK!                   "\
         								     "\n=================================================\n").to_stdout
		end
	end

	context "actions related to players" do

		before do
			allow(@game).to receive(:gets).and_return("shero", "zahra")
		end

		describe "#set_players" do

			it "gets and saves player names" do
				@game.set_players
				expect(@game.player_1).to eql("Shero")
				expect(@game.player_2).to eql("Zahra")
			end
		end

		describe "#current_player" do

			context "when the turn number is even" do
				it "gives the first player" do
					@game.set_players
					expect(@game.current_player).to eql("Shero")
				end
			end

			context "when the turn number is odd" do
				it "gives the second player" do
					@game.set_players
					@game.turn
					expect(@game.current_player).to eql("Zahra")
				end
			end
		end
	end

	context "actions related to playing" do

		before do
			allow(@game).to receive(:gets).and_return("shero", "zahra")
			@game.set_players
			@game.current_player
		end

		describe "#turn" do

			it "increments turn number by 1" do
				@game.turn
				expect(@game.turns).to eql(1)
			end

			it "says whose turn it is" do
				expect { @game.turn }.to output("\nIt's Shero's turn.\n").to_stdout
			end
		end

		describe "#set_tile" do

			context "for Player 1" do

				it "gives '\u263A'" do
					expect(@game.set_tile).to eql("\u263A")
				end
			end

			context "for Player 2" do

				it "gives '\u263B'" do
					@game.turn
					@game.current_player
					expect(@game.set_tile).to eql("\u263B")
				end
			end
		end

		describe "#show_board" do

			it "displays the game board" do
				expect { @game.show_board }.to output("\n 0  1  2  3  4  5  6\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+\n|  |  |  |  |  |  |  |\n+--+--+--+--+--+--+--+").to_stdout
			end
		end

		describe "#play" do

			it "prompts the player to make a move" do
				expect { @game.play }.to output("Pick a column number between '0' and '6', Shero: ").to_stdout
			end

			it "returns the move made by the player" do
				allow(@game).to receive(:gets).and_return("1")
				expect(@game.play).to eql(1)
			end
		end

		describe "#place_tile" do

			it "puts the tile into the right place" do
				allow(@game).to receive(:gets).and_return("5")
				@game.place_tile(@game.play)
				expect(@game.board[5][5]).to eql("\u263A")
			end
		end
	end

	context "winning situations" do

		before do
			allow(@game).to receive(:gets).and_return("shero", "zahra")
			@game.set_players
			@game.current_player
		end

		describe "#hor_win?" do
			it "returns true if 4 of the same kind come side by side" do
				allow(@game).to receive(:gets).and_return("5","4","3","2")
				4.times { @game.place_tile(@game.play) }
				expect(@game.hor_win?).to be true
			end
		end

		describe "#ver_win?" do

			it "returns true if 4 of the same kind come on top of each other" do
				allow(@game).to receive(:gets).and_return("5")
				4.times { @game.place_tile(@game.play) }
				expect(@game.ver_win?).to be true
			end
		end

		describe "#dia_win?" do

			it "returns true if 4 of the same kind are aligned diagonally" do
				allow(@game).to receive(:gets).and_return("5","4","4","2","3","3","3","2","2","3","2")
				11.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				expect(@game.dia_win?).to be true
			end
		end

		describe "#draw?" do

			it "returns true if the board is full without any win" do
				allow(@game).to receive(:gets).and_return("1")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("2")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("3")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("4")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("5")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("6")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				allow(@game).to receive(:gets).and_return("0")
				6.times do
					@game.turn
					@game.place_tile(@game.play)
				end
				expect(@game.draw?).to be true
			end
		end
	end
end
