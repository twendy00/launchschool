# Read through other TA comments
# Refactor code
#   Is anything repeated?
#   Do any methods do more than one thing?
#   Are method names clear?
#   Is overall program clear?

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
POSSIBLE_MOVES = %w(hit stay h s)
card_status = { 'Player': 0, 'Dealer': 0 }
deck = []

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
  dealer_cards = deck.sample(2)

  delete_cards_from_deck(player_cards, deck)
  delete_cards_from_deck(dealer_cards, deck)

  return player_cards, dealer_cards
end

def show_player_cards(cards)
  prompt("Your cards are: #{cards}")
end

def show_dealer_card(card)
  revealed_card = card.sample(1).flatten!
  prompt("One of the dealer's cards is: #{revealed_card}")
end

def ask_player_turn
  prompt("Would you like to hit or stay?")
  turn = ''
  loop do
    turn = gets.chomp
    break if valid_player_turn?(turn)
    prompt("That's not a valid option. Please enter hit or stay.")
  end
  turn = turn.downcase
end

def valid_player_turn?(move)
  move = move.downcase
  POSSIBLE_MOVES.include?(move)
end

def deal_another_card(cards, deck)
  new_card = deck.sample(1)
  cards << new_card.flatten!
  delete_cards_from_deck(new_card, deck)
end

def ace_in_hand?(cards)
  flattened_cards = cards.flatten
  flattened_cards.include?('A')
end

def calculate_card_values(card_values)
  card_values.sum
end

def bust?(card_values)
  total_value = calculate_card_values(card_values)
  total_value > 21
end

def change_ace_value(card_values)
  counter = 0
  loop do
    if bust?(card_values) && card_values[counter] == 11
      card_values[counter] = 1
    end
    counter += 1
    break if counter >= card_values.size
  end
end

def get_card_values(cards)
  card_values = []
  cards.each do |card|
    if card[1].to_i == 0 # For 'K', 'Q', 'J'
      card_values.push(10)
    elsif card[1] == 'A'
      card_values.push(11)
    else
      card_values.push(card[1].to_i)
    end
  end
  card_values
end

def display_card_total(user, card_values)
  prompt("#{user} cards total: #{card_values.sum}")
end

def dealer_hits?(card_value)
  card_value.sum >= 17
end

def distance_from_twenty_one(total_card_value, user, card_status)
  card_status[user] = (21 - total_card_value) if card_status[user] != 'Bust'
end

def identify_winner(card_status)
  if card_status['Player'] == 'Bust' && card_status['Dealer'] == 'Bust'
    'Everyone loses'
  elsif card_status['Dealer'] == 'Bust' ||
        (card_status['Player'] < card_status['Dealer'])
    'Player'
  elsif card_status['Dealer'] == 'Bust' ||
        (card_status['Player'] > card_status['Dealer'])
    'Dealer'
  else
    'Tie'
  end
end

def display_winner(card_status)
  winner = identify_winner(card_status)
  case winner
  when 'Everyone loses'
    prompt("You and the dealer both busted and lost!")
  when 'Player'
    prompt("You are closer to 21 than the dealer. You win!")
  when 'Dealer'
    prompt("The dealer is closer to 21 than you. You lose!")
  when 'Tie'
    prompt("You both have the same number. It's a tie!")
  else
    prompt("Winner not recognizable. Error.")
  end
end

# Execution
deck = INITIAL_DECK
p deck.size
player_cards, dealer_cards = deal_cards(deck)
p deck.size

show_player_cards(player_cards)
show_dealer_card(dealer_cards)

# Player's move
user = 'Player'
player_cards_value = get_card_values(player_cards)
change_ace_value(player_cards_value)
display_card_total(user, player_cards_value)

player_turn = get_player_turn

loop do
  case player_turn
  when 'stay' || 's'
    prompt("You've chosen to stay. The dealer will make their moves now.")
    break
  when 'hit' || 'h'
    deal_another_card(player_cards, deck)
    show_player_cards(player_cards)
    player_cards_value = get_card_values(player_cards)
    change_ace_value(player_cards_value)
    display_card_total(user, player_cards_value)
    if bust?(player_cards_value)
      card_status[user] = 'Bust'
      prompt("You've busted and gone over 21. It's the dealer's turn now.")
      break
    end
    player_turn = get_player_turn
  end
end

total_player_cards = calculate_card_values(player_cards_value)
distance_from_twenty_one(total_player_cards, user, card_status)

# Dealer's move
user = 'Dealer'
dealer_cards_value = get_card_values(dealer_cards)
loop do
  display_card_total(user, dealer_cards_value)
  if bust?(dealer_cards_value)
    card_status[user] = 'Bust'
    break
  end
  break if dealer_hits?(dealer_cards_value)
  deal_another_card(dealer_cards, deck)
  change_ace_value(dealer_cards_value)
  dealer_cards_value = get_card_values(dealer_cards)
end

total_dealer_cards = calculate_card_values(dealer_cards_value)
distance_from_twenty_one(total_dealer_cards, user, card_status)

display_winner(card_status)
