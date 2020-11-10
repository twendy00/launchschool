INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
FIRST_MOVE = ['Player', 'Computer', 'Choose']

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = num }
  new_board
end

brd = initialize_board

=begin
  first move options
    randomly
    last person who lost gets to move first
    alternate between player & computer

  prompt the user - how would you like the first move to be decided
    validate the answer
    use case statement to determine which first move option is used for the remainder of the match

  if randomly
      then assign the first move based on the rand function at the beginning of each game
      if choose is selected, then let the user define the first_person variable

  if last person
    store loser in variable
    set first_person to the loser variable
  
  if alternate
    randomly assign the first move based on the rand function => call the random function that was defined earlier
      then set the first_player variable to the other option
    from there, alternate back and forth

  after setting first_player variable, integrate the first_player variable into the first_move logic
=end