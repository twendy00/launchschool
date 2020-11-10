INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
FIRST_PLAYER = %w(player computer choice)
VALID_PLAY_AGAIN_ANSWERS = %w(yes no y n)
WINS = 5
CENTER_SQUARE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def clear
  system('clear') || system('clr')
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, score)
  clear
  puts "Player Score: #{score['Player']}"
  puts "Computer Score: #{score['Computer']}"
  puts "Tied Games: #{score['Tied Games']}"
  puts ""
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/MethodLength, Metrics/AbcSize

# General game mechanic methods
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def valid_integer?(input)
  input.to_i.to_s == input
end

def joinor(brd)
  empty_squares = empty_squares(brd)
  last_empty_square = empty_squares.pop
  if empty_squares.size == 0
    last_empty_square
  else
    "#{empty_squares.join(', ')} or #{last_empty_square}"
  end
end

def valid_play_again_answer?(answer)
  answer = answer.downcase
  VALID_PLAY_AGAIN_ANSWERS.include?(answer)
end

# First & current player methods
def valid_first_player_choice?(choice)
  choice = choice.downcase
  FIRST_PLAYER.include?(choice) && choice != 'choice'
end

def get_first_player_choice(player_choice)
  loop do
    player_choice = gets.chomp
    break if valid_first_player_choice?(player_choice)
    prompt("That's not a valid choice. Please choose 'player' or 'computer'.")
  end
  player_choice
end

def determine_first_player
  random_index = [0, 1, 2].sample
  case FIRST_PLAYER[random_index]
  when 'player'
    first_player = 'player'
  when 'computer'
    first_player = 'computer'
  when 'choice'
    prompt("You get to choose who goes first! Who would you like to go first?")
    first_player = get_first_player_choice(first_player)
  end
  first_player
end

def alternate_player(player)
  player == 'player' ? 'computer' : 'player'
end

# Player & computer methods
def player_places_piece!(brd)
  square = ''
  loop do
    loop do
      prompt "Choose a square (#{joinor(brd)}):"
      square = gets.chomp
      break if valid_integer?(square)
      prompt("Sorry, that's not a valid integer.")
    end
    square = square.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_must_attack_or_defend?(brd, marker)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count(marker) == 2 &&
                   brd.values_at(*line).count(INITIAL_MARKER) == 1
  end
  false
end

def computer_find_required_square(brd, marker)
  winning_line =
    WINNING_LINES.select do |line|
      brd.values_at(*line).count(marker) == 2 &&
        brd.values_at(*line).count(INITIAL_MARKER) == 1
    end

  winning_line.flatten!.uniq!

  winning_line.each do |sqr|
    return sqr if brd[sqr] == INITIAL_MARKER
  end
end

def computer_places_piece!(brd)
  square =
    if computer_must_attack_or_defend?(brd, COMPUTER_MARKER)
      computer_find_required_square(brd, COMPUTER_MARKER)
    elsif computer_must_attack_or_defend?(brd, PLAYER_MARKER)
      computer_find_required_square(brd, PLAYER_MARKER)
    elsif brd[CENTER_SQUARE] == INITIAL_MARKER
      CENTER_SQUARE
    else
      empty_squares(brd).sample
    end
  sleep(2)

  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, current_player)
  case current_player
  when 'player'
    player_places_piece!(brd)
  when 'computer'
    computer_places_piece!(brd)
  end
end

# Scoring methods
def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score!(score, brd)
  if score[detect_winner(brd)]
    score[detect_winner(brd)] += 1
  else
    score['Tied Games'] += 1
  end
end

def declare_match_winner(score)
  system('clear') || system('clr')
  prompt("Final Player Score: #{score['Player']}")
  prompt("Final Computer Score: #{score['Computer']}")
  prompt("Total Tied Games: #{score['Tied Games']}")
  if score["Player"] >= WINS
    prompt("The player won the match!")
  else
    prompt("The computer won the match!")
  end
end

# Execution
loop do
  clear
  prompt("Welcome to Tic Tac Toe!")
  prompt("First player to win #{WINS} games wins the match!")
  sleep(3)
  clear
  prompt("First player is randomly being decided & will alternate after this.")
  first_player = determine_first_player
  prompt("Looks like #{first_player} gets to go first.")
  sleep(3.5)
  score = { "Player" => 0, "Computer" => 0, "Tied Games" => 0 }

  loop do
    board = initialize_board
    current_player = first_player

    loop do
      display_board(board, score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      if someone_won?(board) || board_full?(board)
        first_player = alternate_player(first_player)
        break
      end
    end

    display_board(board, score)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won the game!"
    else
      prompt "This game is a tie!"
    end
    sleep(3)

    update_score!(score, board)

    if score["Player"] >= WINS || score["Computer"] >= WINS
      declare_match_winner(score)
      break
    end
  end

  prompt "Play another match? (y or n)"
  answer = ''

  loop do
    answer = gets.chomp
    break if valid_play_again_answer?(answer)
    prompt("That's not a valid answer. Please enter 'yes' or 'no'.")
  end

  break unless answer.downcase.start_with?('y')
end

clear
prompt "Thanks for playing Tic Tac Toe. Good bye."
