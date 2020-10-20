VALID_CHOICES = %w(rock paper scissors lizard spock)

VALID_CHOICES_ABBREVIATED = { 'r' => 'rock',
                              'p' => 'paper',
                              'sc' => 'scissors',
                              'l' => 'lizard',
                              'sp' => 'spock' }

WINNING_LOGIC = { 'rock' => ['lizard', 'scissors'],
                  'paper' => ['rock', 'spock'],
                  'scissors' => ['paper', 'lizard'],
                  'lizard' => ['spock', 'paper'],
                  'spock' => ['scissors', 'rock'] }

VALID_PLAY_AGAIN_ANSWERS = %w(yes no)

VALID_PLAY_AGAIN_ANSWERS_ABBREVIATED = { 'y' => 'yes',
                                         'n' => 'no' }

GAME_ROUNDS = 5

score = { player: 0,
          computer: 0 }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def clear_screen
  system("clear") || system("cls")
end

def winning_move?(first, second)
  WINNING_LOGIC[first].include?(second)
end

def game_winner(player,computer)
  if winning_move?(player, computer)
    "Player"
  elsif winning_move?(computer, player)
    "Computer"
  end
end

def display_game_winner_message(winner)
  if winner == "Player"
    prompt("You won!")
  elsif winner == "Computer"
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def increment_wins(winner, score)
  if winner == "Player"
    score[:player] += 1
  elsif winner == "Computer"
    score[:computer] += 1
  end
end 

def display_score(score)
  prompt("User's Score: #{score[:player]}")
  prompt("Computer's Score: #{score[:computer]}")
end

def display_match_outcome(user, computer)
  if user > computer
    prompt("You won the match by winning #{GAME_ROUNDS} games first. Good job!")
  else
    print("=> The computer won the match by winning #{GAME_ROUNDS} games first. ")
    puts("Better luck next time!")
  end
end

def validate_choice(choice)
  choice = choice.downcase()
  if VALID_CHOICES.include?(choice)
    choice
  elsif VALID_CHOICES_ABBREVIATED.key?(choice)
    VALID_CHOICES_ABBREVIATED[choice]
  else
    prompt("That's not a valid choice.")
  end
end

def valid_play_again_choice?(choice)
  choice = choice.downcase()
  if VALID_PLAY_AGAIN_ANSWERS.include?(choice)
    choice
  elsif VALID_PLAY_AGAIN_ANSWERS_ABBREVIATED.key?(choice)
    VALID_PLAY_AGAIN_ANSWERS_ABBREVIATED[choice]
  else
    prompt("That's not a valid choice. Please enter yes or no.")
  end
end

prompt("Welcome to the rock, paper, scissors, lizard, spock game!")
prompt("The first player to win #{GAME_ROUNDS} wins the match.")
sleep(2)
clear_screen()

loop do
  score[:player] = 0
  score[:computer] = 0
  play_again_answer = ''

  loop do
    user_choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      prompt("You may also select from one of these abbreviations #{VALID_CHOICES_ABBREVIATED.keys}")
      user_choice = Kernel.gets().chomp()
      user_choice = validate_choice(user_choice)
      break if user_choice
    end

    computer_choice = VALID_CHOICES.sample
    prompt("You chose: #{user_choice}. Computer chose: #{computer_choice}.")

    winner = game_winner(user_choice, computer_choice)
    display_game_winner_message(winner)
    increment_wins(winner, score)
    display_score(score)
    sleep(3)
    clear_screen()
    break if score[:player] >= GAME_ROUNDS || score[:computer] >= GAME_ROUNDS
  end

  display_match_outcome(score[:player], score[:computer])

  loop do
    prompt("Do you want to play again?")
    play_again_answer = Kernel.gets().chomp()
    break if valid_play_again_choice?(play_again_answer)
  end

  clear_screen()
  break unless play_again_answer.downcase().start_with?('y')
end

prompt("Thank you for playing.")
