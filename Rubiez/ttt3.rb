# GAME LOGIC
# - Draw Board
# - Decide who goes first
# - Player takes a turn and picks from available squares
# - Check to see if winner
# - Check if any squares are left
# - Player 2 takes a turn
# - Play again?

# Approach to building from scratch
# - Game start & Play again?
# - Initialize empty squares
# - Draw the Board
# - Deciding who goes first randomly
# - Building a slight delay for the computers turn to improve UX for player. Game demo in the course video instantly executed the computers' turn as soon as player had gone making a slightly confusing UX for player.
# - Checking which squares were available for selection and telling player which these squares were including a check to ensure the player had selected an empty squares
# - Output a message that the game has ended

# METHODS and constants below

# constants
# winning lines: rows, columns, and diagonals
WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

#markers
X = "X"
O = "O"

# available squares
def available_squares(squares)
  squares.select {|k,v| v == " "}.keys
end


#draw the board
def draw_board(squares)
  system 'clear'
  puts "#{squares[1]}|#{squares[2]}|#{squares[3]}"
  puts "-----"
  puts "#{squares[4]}|#{squares[5]}|#{squares[6]}"
  puts "-----"
  puts "#{squares[7]}|#{squares[8]}|#{squares[9]}"
end

def player(squares)
  if available_squares(squares).any?
    puts "Choose an available square from #{available_squares(squares)}."
    i = gets.chomp.to_i
      if available_squares(squares).include?(i)
        squares[i] = "X"
      else
        player(squares)
      end
    draw_board(squares)
  end
end

# The two_in_a_row method checks to see if there is a combination that exists whereby a player has two of their markers in a line and the remaining square is emtpy. For example true if ‘x’ ‘ ‘ ‘x’ false if ‘x’ ‘o’ ‘x’.
# The check_for_winner method checks to see if either a line is filled exclusively with either all ‘x’ or ‘o’ for example true if ‘x’ ‘x’ ‘x’ or ‘o’ ‘o’ ‘o’.



# Computer checks to see if it can attack
# If it cannot attack it will see if it needs to defend
# If it doesn’t need to defend it will just choose a random available square.


def computer(line, squares)
  puts "Computer chooses a square."
  sleep 0.5

  defend_this_square = nil
  attacked = false

  #attack
  WINNING_LINES.each do |l|
    defend_this_square = two_in_a_row({1[0] => squares[1[0]], 1[1] => squares[1[1]], 1[2] => squares[1[2]]}, O)
    if defend_this_square
      squares[defend_this_square] = O
      attacked = true
      break
    end
  end

  #defend
  if attacked == false
    WINNING_LINES.each do |l|
      defend_this_square = two_in_a_row({1[0] => squares[1[0]], 1[1] => squares[1[1]], 1[2] => squares[1[2]]}, X)
      if defend_this_square
        squares[defend_this_square] = O
        break
      end
    end
  end
  squares[available_squares(squares).sample] = O unless defend_this_square
  draw_board(squares)
end

#checks to see if two markers in a row
def two_in_a_row(hash, marker)
  if hash.values.count(marker) == 2
    hash.select{|k,v| v == " "}.keys.first
  else
    false
  end
end

#check for a winner method
def check_for_winner(line, squares)
  if line.find {|l| l.all? {|k| squares[k] == X} }
    puts "player WINS!!!"
    true
  elsif line.find {|l| l.all? {|k| squares[k] == O} }
    puts "computer wins, you LOSE!!!"
    true
  end
end



# play again?
play_again = 'y'

# while loop that includes game play logic
while play_again == 'y'

#GAME CODE BELOW

  # initialize the empty hash that will store the board squares
  board_squares = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}

  # players stored in array so player can be chosen at random
  players = ["player", "computer"]
  
  #randomizing first player
  goes_first = players.sample

  # show players the empty board
  draw_board(board_squares)

  #conditional that checks which loop to execute: player or computer
  if goes_first == "player"
    begin
      break if check_for_winner(WINNING_LINES, board_squares) == true
      player(board_squares)
      break if check_for_winner(WINNING_LINES, board_squares) == true
      computer(WINNING_LINES, board_squares)
    end until available_squares(board_squares).empty?
  elsif goes_first == "computer"
    begin
      break if check_for_winner(WINNING_LINES, board_squares) == true
      computer(WINNING_LINES, board_squares)
      break if check_for_winner(WINNING_LINES, board_squares) == true
      player(board_squares)
    end until available_squares(board_squares).empty?
  end

  sleep 0.5
  puts "GAME OVER"

  # play again?
  sleep 0.5
  puts "Play again? (y/n)"
  play_again = gets.chomp
end


