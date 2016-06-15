class Game
	attr_accessor :board, :player_1, :player_2

	def initialize(p1, p2)
		@board = [["","","","","","",""],
				["","","","","","",""],
				["","","","","","",""],
				["","","","","","",""],
				["","","","","","",""],
				["","","","","","",""]]
		@player_1 = p1
		@player_2 = p2
	end
end