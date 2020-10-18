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

def prompt(message)
  Kernel.puts("=> #{message}")
end

def clear_screen
  system("clear") || system("cls")
end

def winning_move?(first, second)
  WINNING_LOGIC[first].include?(second)
end

def game_winner(player, computer)
  if winning_move?(player, computer)
    "You won!"
  elsif winning_move?(computer, player)
    "Computer won!"
  else
    "It's a tie!"
  end
end

def increment_user_wins(result, user)
  if result == "You won!"
    user + 1
  else
    user
  end
end

def increment_computer_wins(result, computer)
  if result == "Computer won!"
    computer + 1
  else
    computer
  end
end

def display_score(user_wins, computer_wins)
  prompt("User's Score: #{user_wins}")
  prompt("Computer's Score: #{computer_wins}")
end

def display_match_outcome(user, computer)
  if user > computer
    prompt("You won the match by winning 5 games first. Good job!")
  else
    print("=> The computer won the match by winning 5 games first. ")
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
sleep(2)
clear_screen()

loop do
  user_wins = 0
  computer_wins = 0
  play_again_answer = ''

  loop do
    user_choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      user_choice = Kernel.gets().chomp()
      user_choice = validate_choice(user_choice)
      break if user_choice
    end

    computer_choice = VALID_CHOICES.sample
    prompt("You chose: #{user_choice}. Computer chose: #{computer_choice}.")

    result = game_winner(user_choice, computer_choice)
    prompt(result)
    user_wins = increment_user_wins(result, user_wins)
    computer_wins = increment_computer_wins(result, computer_wins)
    display_score(user_wins, computer_wins)
    sleep(3)
    clear_screen()
    break if user_wins >= 5 || computer_wins >= 5
  end

  display_match_outcome(user_wins, computer_wins)

  loop do
    prompt("Do you want to play again?")
    play_again_answer = Kernel.gets().chomp()
    break if valid_play_again_choice?(play_again_answer)
  end

  clear_screen()
  break unless play_again_answer.downcase().start_with?('y')
end

prompt("Thank you for playing.")
