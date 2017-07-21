require 'pry'

WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

X = "X"
O = "O"

def available_spaces(spaces)
  spaces.select {|k,v| v == " "}.keys
end

def draw_board(spaces)
  system 'clear'
  puts "#{spaces[1]}|#{spaces[2]}|#{spaces[3]}"
  puts "-----"
  puts "#{spaces[4]}|#{spaces[5]}|#{spaces[6]}"
  puts "-----"
  puts "#{spaces[7]}|#{spaces[8]}|#{spaces[9]}"
end

def player(spaces)
  if available_spaces(spaces).any?
    puts "Choose an available spaces from #{available_spaces(spaces)}."
    position = gets.chomp.to_i
      if available_spaces(spaces).include?(position)
        spaces[position] = "X"
      else
        player(spaces)
      end
    draw_board(spaces)
  end
end

def computer(line, spaces)
  defend_this_space = nil
  attacked = false

  WINNING_LINES.each do |l|
    defend_this_space = two_in_a_row({1[0] => spaces[1[0]], 1[1] => spaces[1[1]], 1[2] => spaces[1[2]]}, O)
    if defend_this_space
      spaces[defend_this_space] = O
      attacked = true
      break
    end
  end

  if attacked == false
    WINNING_LINES.each do |l|
      defend_this_space = two_in_a_row({1[0] => spaces[1[0]], 1[1] => spaces[1[1]], 1[2] => spaces[1[2]]}, X)
      if defend_this_space
        spaces[defend_this_space] = O
        attacked = true
        break
      end
    end
  end

  spaces[available_spaces(spaces).sample] = O unless defend_this_space
  draw_board(spaces)
end

def two_in_a_row(hash, marker)
  if hash.values.count(marker) == 2
    hash.select{|k,v| v == " "}.keys.first
  else
    false
  end
end

def check_for_winner(line, spaces)
  if line.find {|l| l.all? {|k| spaces[k] == X} }
    puts "YOU WIN!"
    true
  elsif line.find {|l| l.all? {|k| spaces[k] == O} }
    puts "Computer won, you LOSE!"
    true
  end
end

play_again = "y"

while play_again == "y"

  players = ["player", "computer"]

  board_spaces = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}

  goes_first = players.sample

  draw_board(board_spaces)

  if goes_first == 'player'
    begin
      break if check_for_winner(WINNING_LINES, board_spaces) == true
      player(board_spaces)
      break if check_for_winner(WINNING_LINES, board_spaces) == true
      computer(WINNING_LINES, board_spaces)
    end until available_spaces(board_spaces).empty?
  elsif goes_first == 'computer'
    begin
      break if check_for_winner(WINNING_LINES, board_spaces) == true
      computer(WINNING_LINES, board_spaces)
      break if check_for_winner(WINNING_LINES, board_spaces) == true
      player(board_spaces)
    end until available_spaces(board_spaces).empty?
  end

  sleep 0.5
  puts "GAME OVER."

  sleep 0.5
  puts "Play again? (y/n)"
  play_again = gets.chomp
end