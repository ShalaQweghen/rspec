class Game
  attr_reader :turns, :board, :player_1, :player_2

  def initialize
    @board = [[" "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "],
              [" "," "," "," "," "," "," "]]
    @player_1 = nil
    @player_1 = nil
    @current_player = nil
    @turns = 0
  end

  def start
    system("clear")
    sleep 1
    puts "              WELCOME TO CONNECT FOUR!           "\
         "\n\n================================================="\
         "\nThis is a game where you will try to connect four"\
         "\nof your tiles before your opponent. They can be  "\
         "\nconnected vertically, horizontally or diagonally."\
         "\n\n                    GOOD LUCK!                   "\
         "\n================================================="
  end

  def set_players
    print "\nWhat is the name of Player 1?: "
    @player_1 = gets.chomp.downcase.capitalize
    print "What is the name of Player 2?: "
    @player_2 = gets.chomp.downcase.capitalize
  end

  def turn
    puts "\nIt's #{current_player}'s turn."
    @turns += 1
  end

  def current_player
    @current_player = @turns.odd? ? @player_2 : @player_1
  end

  def set_tile
    return @current_player == @player_1 ? "\u263A" : "\u263B"
  end

  def show_board
    puts "\n 0  1  2  3  4  5  6"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[0][0]} |#{@board[0][1]} |#{@board[0][2]} |#{@board[0][3]} |#{@board[0][4]} |#{@board[0][5]} |#{@board[0][6]} |"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[1][0]} |#{@board[1][1]} |#{@board[1][2]} |#{@board[1][3]} |#{@board[1][4]} |#{@board[1][5]} |#{@board[1][6]} |"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[2][0]} |#{@board[2][1]} |#{@board[2][2]} |#{@board[2][3]} |#{@board[2][4]} |#{@board[2][5]} |#{@board[2][6]} |"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[3][0]} |#{@board[3][1]} |#{@board[3][2]} |#{@board[3][3]} |#{@board[3][4]} |#{@board[3][5]} |#{@board[3][6]} |"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[4][0]} |#{@board[4][1]} |#{@board[4][2]} |#{@board[4][3]} |#{@board[4][4]} |#{@board[4][5]} |#{@board[4][6]} |"\
    "\n+--+--+--+--+--+--+--+"\
    "\n|#{@board[5][0]} |#{@board[5][1]} |#{@board[5][2]} |#{@board[5][3]} |#{@board[5][4]} |#{@board[5][5]} |#{@board[5][6]} |"\
    "\n+--+--+--+--+--+--+--+"
  end

  def play
    print "Pick a column number between '0' and '6', #{@current_player}: "
    move = gets.chomp.to_i
    return move
  end

  def place_tile(move)
    if @board[5][move] == " "
      @board[5][move] = set_tile
    elsif @board[4][move] == " "
      @board[4][move] = set_tile
    elsif @board[3][move] == " "
      @board[3][move] = set_tile 
    elsif @board[2][move] == " "
      @board[2][move] = set_tile 
    elsif @board[1][move] == " "
      @board[1][move] = set_tile
    elsif @board[0][move] == " "
      @board[0][move] = set_tile
    else
      print "The column you picked is already full. Pick another column: "
      move_1 = gets.chomp.to_i
      place_tile(move_1)
    end
  end

  def hor_win?
    @board.each do |ary|
      if ary[0..3].all? { |n| n == "\u263A" } || ary[0..3].all? { |n| n == "\u263B" }
        return true
      elsif ary[1..4].all? { |n| n == "\u263A" } || ary[1..4].all? { |n| n == "\u263B" }
        return true
      elsif ary[2..5].all? { |n| n == "\u263A" } || ary[2..5].all? { |n| n == "\u263B" }
        return true
      elsif ary[3..6].all? { |n| n == "\u263A" } || ary[3..6].all? { |n| n == "\u263B" }
        return true
      end
    end
    return false
  end

  def ver_win?
    board = @board.flatten
    board.each_index do |idx|
      if idx + 21 <= board.size-1
        return true if [board[idx], board[idx+7], board[idx+14], board[idx+21]].all? { |n| n == "\u263A" }
        return true if [board[idx], board[idx+7], board[idx+14], board[idx+21]].all? { |n| n == "\u263B" }
      end
    end
    return false
  end

  def dia_win?
    board = @board.flatten
    board.each_index do |idx|
      if [0,1,2,3,7,8,9,10,14,15,16,17].include?(idx)
        return true if [board[idx], board[idx+8], board[idx+16], board[idx+24]].all? { |n| n == "\u263A" }
        return true if [board[idx], board[idx+8], board[idx+16], board[idx+24]].all? { |n| n == "\u263B" }
      end
    end
    board.each_index do |idx|
      if [3,4,5,6,10,11,12,13,17,18,19,20].include?(idx)
        return true if [board[idx], board[idx+6], board[idx+12], board[idx+18]].all? { |n| n == "\u263A" }
        return true if [board[idx], board[idx+6], board[idx+12], board[idx+18]].all? { |n| n == "\u263B" }
      end
    end
    return false
  end

  def draw?
    true if @board.flatten.all? { |n| n != " " }
  end

  def over?
    if ver_win?
      true
    elsif hor_win?
      true
    elsif dia_win?
      true
    else 
      false
    end
  end

  def proceed
    start
    set_players
    show_board
    until over?
      if draw?
        puts "It's a draw!"
        break
      end
      turn
      place_tile(play)
      show_board
    end
    puts "Congratulations! #{@current_player} wins!".upcase.center(50)
  end
end

Game.new.proceed