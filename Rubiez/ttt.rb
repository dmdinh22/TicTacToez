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

def initialize_grid
  g = { }
  (1..9).each {|position| g[position] = ' '}
  g
end

def draw_grid(g)
  system 'clear' # clear board instead of adding to bottom
  puts " #{g[1]} | #{g[2]} | #{g[3]}"
  puts "-----------"
  puts " #{g[4]} | #{g[5]} | #{g[6]}"
  puts "-----------"
  puts " #{g[7]} | #{g[8]} | #{g[9]}"
end

def empty_positions(g)
  g.select {|k, v| v == ' '}.keys
end

def player_picks_space(g)
  puts "Pick a space (1 - 9):"
  position = gets.chomp.to_i
  g[position] = 'X'
end

def computer_picks_space(g)
  position = empty_positions(g).sample
  g[position] = 'O'
end

def check_winner(g)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if g[line[0]] == 'X' and g[line[1]] == 'X' and g[line[2]] == 'X'
      return "Player"
    elsif g[line[0]] == 'O' and g[line[1]] == 'O' and g[line[2]] == 'O'
      return "Computer"
    else
      return nil
    end
  end
end


grid = initialize_grid
draw_grid(grid)

begin
  player_picks_space(grid)
  computer_picks_space(grid)
  draw_grid(grid)
  winner = check_winner(grid)
end until winner || empty_positions(grid).empty?

if winner
  puts "#{winner} won!"
else
  puts "It's a tie!"
end


