require 'pry'
# 1. Come up with requirements/ specifications, which will determine the scope.
# 2. Application logic, sequence of steps - focus on a layer at a time
# 3. Translation of those steps into code - focus on a layer at a time
# 4. Run code to verify logic

# Pseudo code
# Create a 3x3 grid

# Assign Player to "X"
# Assign Computer to "O"

# loop until a winner or all squares are taken
#   Player chooses an empty space in 3x3 grid
#   CHECK for winner
#   Computer chooses an empty space in 3x3 grid
#   CHECK for winner
# end

# if there's a winner
#   show the winner
# or else
#   it's a tie

# 3 in a row, in a column, or diagonally left or diagonally right wins
# Tie if all spaces filled but neither player wins

def empty_board
  { 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
end

board = empty_board
# board is the data structure to hold values for player and computer positions.

def draw_board(board)
  system 'clear' #clears board instead of adding to the bottom
  puts "      |       |       "
  puts "#{board[1]}     |#{board[2]}      |#{board[3]}"
  puts "------+-------+-------"
  puts "      |       |       "
  puts "#{board[4]}     |#{board[5]}      |#{board[6]}"
  puts "------+-------+-------"
  puts "      |       |       "
  puts "#{board[7]}     |#{board[8]}      |#{board[9]}"
end

def empty_position(board)
  board.select {|k,v| v== " "}.keys
end

def player_position(board)
  begin
    position = gets.chomp.to_i
  end until empty_position(board).include?(position)
  board[position] = "X"
end

def computer_position(board)
  case 
  when two_in_a_row(board, "X")
      position = two_in_a_row(board, "X")
  when two_in_a_row(board, "O")
    position = two_in_a_row(board, "O")
  else
    position = empty_position(board).sample
  end
  board[position] = "O"
end

def two_in_a_row(board, marker)
  if board.values.count(marker) == 2
    board.select{|k,v| v == ' '}.keys.first
  else
    false
  end
end

def check_winner(board)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  winning_lines.each do |line|
    return "Player" if board.values_at(*line).count("X") == 3
    return "Computer" if board.values_at(*line).count("O") == 3
  end
  nil
end

loop do
draw_board(board)
  begin
    puts "Pick a space (1-9):"
    player_position(board)
    computer_position(board)
    draw_board(board)
    winner = check_winner(board)
  end until winner || empty_position(board).empty?

  if winner
    puts "#{winner} won!"
  else
    puts "It's a tie!"
  end

  puts "Would you like to play again? Enter 'y' to continue, or any other key to exit."
  if gets.chomp.downcase == 'y'
    board = empty_board
  else
    break
  end
end

puts "Thank you for playing Tic Tac Toe!"
