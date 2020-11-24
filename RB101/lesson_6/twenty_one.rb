INITIAL_DECK = [['C', '2'], ['C', '3'], ['C', '4'], ['C', '5'], ['C', '6'],
                ['C', '7'], ['C', '8'], ['C', '9'], ['C', '10'], ['C', 'J'],
                ['C', 'Q'], ['C', 'K'], ['C', 'A'], # clubs
                ['D', '2'], ['D', '3'], ['D', '4'], ['D', '5'], ['D', '6'],
                ['D', '7'], ['D', '8'], ['D', '9'], ['D', '10'], ['D', 'J'],
                ['D', 'Q'], ['D', 'K'], ['D', 'A'], # diamonds
                ['H', '2'], ['H', '3'], ['H', '4'], ['H', '5'], ['H', '6'],
                ['H', '7'], ['H', '8'], ['H', '9'], ['H', '10'], ['H', 'J'],
                ['H', 'Q'], ['H', 'K'], ['H', 'A'], # hearts
                ['S', '2'], ['S', '3'], ['S', '4'], ['S', '5'], ['S', '6'],
                ['S', '7'], ['S', '8'], ['S', '9'], ['S', '10'], ['S', 'J'],
                ['S', 'Q'], ['S', 'K'], ['S', 'A']] # spades
WINNING_VALUE = 21
DEALER_HITS = 17
WINNING_GAMES = 5
POSSIBLE_MOVES = %w(hit stay h s)

def clear
  system('clear') || system('clr')
end

def prompt(msg)
  puts "=> #{msg}"
end

def delete_cards_from_deck(cards, deck)
  cards.each do |card|
    deck.delete(card)
  end
end

def deal_cards(deck)
  player_cards = deck.sample(2)
  delete_cards_from_deck(player_cards, deck)
  dealer_cards = deck.sample(2)
  delete_cards_from_deck(dealer_cards, deck)

  return player_cards, dealer_cards
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
  POSSIBLE_MOVES.include?(move)
end

def deal_another_card(cards, deck)
  new_card = deck.sample(1)
  cards << new_card.flatten!
  delete_cards_from_deck(new_card, deck)
end

def store_card_values(cards)
  card_values = []
  cards.each do |card|
    if card[1] == 'A'
      card_values.push(11)
    elsif card[1].to_i == 0 # For 'K', 'Q', 'J'
      card_values.push(10)
    else
      card_values.push(card[1].to_i)
    end
  end
  card_values
end

def bust?(total)
  total > WINNING_VALUE
end

def change_ace_value(card_values, total)
  counter = 0
  loop do
    if bust?(total) && card_values[counter] == 11
      card_values[counter] = 1
    end
    total = card_values.sum
    counter += 1
    break if counter >= card_values.size
  end
end

def process_moves(cards, turn)
  card_values = store_card_values(cards)
  prompt("Cards in hand: #{cards}") if turn == 'Player'
  total = card_values.sum
  change_ace_value(card_values, total)
  total = card_values.sum
  prompt("Card total: #{total}") if turn == 'Player'
  total
end

def identify_winner(player_total, dealer_total)
  if player_total > WINNING_VALUE && dealer_total > WINNING_VALUE
    :Everyone_loses
  elsif player_total > WINNING_VALUE
    :Dealer
  elsif dealer_total > WINNING_VALUE
    :Player
  elsif (WINNING_VALUE - player_total) > (WINNING_VALUE - dealer_total)
    :Dealer
  elsif (WINNING_VALUE - player_total) < (WINNING_VALUE - dealer_total)
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

def process_end_game(player_cards, player_total, dealer_cards,
                     dealer_total, score)
  clear
  prompt("Final Results:")
  prompt("Player's cards: #{player_cards} & player's total: #{player_total}.")
  prompt("Dealer's cards: #{dealer_cards} & dealer's total: #{dealer_total}.")
  winner = identify_winner(player_total, dealer_total)
  display_winner(winner)
  score[winner] += 1 if score[winner]
  puts ""

  prompt("Player's Score: #{score[:Player]}")
  prompt("Dealer's Score: #{score[:Dealer]}")
  sleep(5)
  clear
end

# Execution
loop do
  score = { Player: 0, Dealer: 0 }
  clear

  prompt("Welcome to #{WINNING_VALUE}!")
  prompt("The player closest to #{WINNING_VALUE} without going over wins.")
  prompt("First player to win #{WINNING_GAMES} games wins the match.")
  sleep(3)
  clear

  loop do
    player_total = 0
    dealer_total = 0

    deck = INITIAL_DECK
    player_cards, dealer_cards = deal_cards(deck)

    prompt("One of the dealer's cards is #{dealer_cards[0]}.")
    prompt("You get to go first.")
    sleep(2)
    clear

    # Player's move
    turn = 'Player'
    player_total = process_moves(player_cards, turn)
    player_turn = ask_player_turn

    loop do
      clear
      case player_turn
      when 'stay', 's'
        prompt("You've chosen to stay.")
        break
      when 'hit', 'h'
        deal_another_card(player_cards, deck)
        player_total = process_moves(player_cards, turn)
        if bust?(player_total)
          prompt("You've busted and gone over #{WINNING_VALUE}!")
          break
        end
        player_turn = ask_player_turn
      end
    end
    sleep(1.5)
    clear

    if bust?(player_total)
      dealer_total = store_card_values(dealer_cards).sum
      process_end_game(player_cards, player_total, dealer_cards,
                       dealer_total, score)
      break if score[:Player] >= WINNING_GAMES ||
               score[:Dealer] >= WINNING_GAMES
      next
    end

    # Dealer's move
    turn = 'Dealer'
    prompt("It's the dealer's turn now.")
    prompt("Dealer is making their moves....")
    sleep(1.5)

    dealer_total = process_moves(dealer_cards, turn)
    loop do
      if bust?(dealer_total)
        prompt("The dealer busted and went over #{WINNING_VALUE}!")
        break
      end
      break if dealer_total >= DEALER_HITS
      deal_another_card(dealer_cards, deck)
      dealer_total = process_moves(dealer_cards, turn)
    end
    sleep(2)

    process_end_game(player_cards, player_total, dealer_cards,
                     dealer_total, score)
    break if score[:Player] >= WINNING_GAMES || score[:Dealer] >= WINNING_GAMES
  end
  prompt("You won the match! Great job!") if score[:Player] >= WINNING_GAMES
  prompt("You lost the match! Too bad!") if score[:Dealer] >= WINNING_GAMES

  break if ask_play_again.start_with?('n')
end
