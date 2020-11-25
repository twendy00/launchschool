SUITS = %w(Clubs Diamonds Hearts Spades)
VALUES = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']
WINNING_VALUE = 21
DEALER_HITS = 17
WINNING_GAMES = 5

def clear
  system('clear') || system('clr')
end

def prompt(msg)
  puts "=> #{msg}"
end

def assign_points(card)
  case card[:value]
  when 'Ace'
    card[:points] = 11
  when 'Jack', 'Queen', 'King'
    card[:points] = 10
  else
    card[:points] = card[:value].to_i
  end
end

def initialize_deck
  deck = []
  VALUES.each do |value|
    SUITS.each do |suit|
      card = {}
      card[:suit] = suit
      card[:value] = value
      card[:points] = assign_points(card)
      deck << card
    end
  end
  deck
end

def ask_player_turn
  prompt("Would you like to hit or stay?")
  move = ''
  loop do
    move = gets.chomp.downcase
    break if valid_player_move?(move)
    prompt("That's not a valid option. Please enter hit or stay.")
  end
  move
end

def valid_player_move?(move)
  %w(hit stay h s).include?(move)
end

def store_card_points(cards)
  card_points = []
  cards[:cards].each { |card| card_points << card[:points] }
  card_points
end

def bust?(cards)
  cards[:total] > WINNING_VALUE
end

def change_ace_points(card_points, cards)
  counter = 0
  loop do
    if bust?(cards) && card_points[counter] == 11
      card_points[counter] = 1
    end
    cards[:total] = card_points.sum
    counter += 1
    break if counter >= card_points.size
  end
end

def show_cards(cards)
  cards[:cards].each { |card| prompt("#{card[:value]} of #{card[:suit]}") }
end

def process_moves(cards, turn)
  card_points = store_card_points(cards)
  prompt("Cards in hand:") if turn == 'Player'
  show_cards(cards) if turn == 'Player'
  cards[:total] = card_points.sum
  change_ace_points(card_points, cards)
  prompt("Total: #{cards[:total]}") if turn == 'Player'
end

def identify_winner(player, dealer)
  if player[:total] > WINNING_VALUE
    :Dealer
  elsif dealer[:total] > WINNING_VALUE
    :Player
  elsif (WINNING_VALUE - player[:total]) > (WINNING_VALUE - dealer[:total])
    :Dealer
  elsif (WINNING_VALUE - player[:total]) < (WINNING_VALUE - dealer[:total])
    :Player
  else
    :Tie
  end
end

def display_winner(winner)
  case winner
  when :Everyone_loses
    prompt("You and the dealer both lost this game!")
  when :Player
    prompt("You win this game!")
  when :Dealer
    prompt("You lose this game!")
  when :Tie
    prompt("You both have the same number. This game is a tie!")
  else
    prompt("Winner not recognizable. Error.")
  end
end

def show_final_cards(player, dealer)
  clear
  prompt("Final Outcome:")
  puts "--------------------"
  prompt("Player's Hand:")
  show_cards(player)
  prompt("Total: #{player[:total]}")
  puts "--------------------"
  prompt("Dealer's Hand:")
  show_cards(dealer)
  prompt("Total: #{dealer[:total]}")
end

def show_score(score)
  prompt("Player's Score: #{score[:Player]}")
  prompt("Dealer's Score: #{score[:Dealer]}")
  sleep(5)
  clear
end

def process_end_game(player, dealer, score)
  show_final_cards(player, dealer)
  winner = identify_winner(player, dealer)
  puts "--------------------"
  display_winner(winner)
  score[winner] += 1 if score[winner]
  puts ""
  show_score(score)
end

def ask_play_again
  answer = ''
  prompt("Would you like to play another match?")
  loop do
    answer = gets.chomp.downcase
    break if %w(yes no y n).include?(answer)
    prompt("That's not a valid answer. Please enter yes or no.")
  end
  answer
end

# Execution
loop do
  score = { Player: 0, Dealer: 0 }
  clear

  prompt("Welcome to #{WINNING_VALUE}!")
  prompt("The player closest to #{WINNING_VALUE} without going over wins.")
  prompt("First player to win #{WINNING_GAMES} games wins the match.")
  sleep(2.5)
  clear

  loop do
    player = { total: 0, cards: [] }
    dealer = { total: 0, cards: [] }

    deck = initialize_deck.shuffle
    2.times do
      player[:cards].push(deck.pop)
      dealer[:cards].push(deck.pop)
    end

    prompt("The round is starting!")
    prompt("Dealer's revealed card: #{dealer[:cards][0][:value]} " \
      "of #{dealer[:cards][0][:suit]}")
    prompt("You get to go first.")
    sleep(2.5)
    clear

    # Player's move
    turn = 'Player'
    process_moves(player, turn)
    player_turn = ask_player_turn

    loop do
      clear
      case player_turn
      when 'stay', 's'
        prompt("You've chosen to stay.")
        break
      when 'hit', 'h'
        player[:cards].push(deck.pop)
        process_moves(player, turn)
        if bust?(player)
          prompt("You've busted and gone over #{WINNING_VALUE}!")
          break
        end
        player_turn = ask_player_turn
      end
    end
    sleep(1.5)
    clear

    if bust?(player)
      dealer[:total] = store_card_points(dealer).sum
      process_end_game(player, dealer, score)
      break if score[:Player] >= WINNING_GAMES ||
               score[:Dealer] >= WINNING_GAMES
      next
    end

    # Dealer's move
    turn = 'Dealer'
    prompt("It's the dealer's turn now.")
    prompt("Dealer is making their moves....")
    sleep(1)

    process_moves(dealer, turn)
    loop do
      if bust?(dealer)
        prompt("The dealer busted and went over #{WINNING_VALUE}!")
        break
      end
      break if dealer[:total] >= DEALER_HITS
      dealer[:cards].push(deck.pop)
      process_moves(dealer, turn)
    end
    sleep(1.5)

    # Game ending
    process_end_game(player, dealer, score)
    break if score[:Player] >= WINNING_GAMES || score[:Dealer] >= WINNING_GAMES
  end
  prompt("You won the match! Great job!") if score[:Player] >= WINNING_GAMES
  prompt("You lost the match! Too bad!") if score[:Dealer] >= WINNING_GAMES

  if ask_play_again.start_with?('n')
    prompt("Thanks for playing #{WINNING_VALUE}!")
    break
  end
end
