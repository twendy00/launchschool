produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

# def select_fruit(produce_hash)
#   fruit = produce_hash.select { |key, value| value == 'Fruit' }
# end

def select_fruit(produce_hash)
  produce_type = produce_hash.keys
  counter = 0
  fruit = Hash.new

  loop do
    break if counter >= produce_type.size
    current_produce = produce_type[counter]

    if produce_hash[current_produce] == "Fruit"
      fruit.store(current_produce, produce_hash[current_produce])
    end
      
    counter += 1
  end
  fruit
end

puts select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

my_numbers = [1, 4, 3, 7, 2, 6]

def double_numbers(numbers)
  counter = 0

  loop do 
    break if counter >= numbers.size

    numbers[counter] = numbers[counter] * 2
    
    counter += 1
  end
    numbers
end

puts double_numbers(my_numbers) # => [2, 8, 6, 14, 4, 12]

def double_odd_numbers(my_numbers)
  counter = 0
  doubled_numbers = []

  loop do 
    break if counter >= my_numbers.size

    if counter.odd?
      doubled_numbers << my_numbers[counter] * 2
    end

    counter += 1
  end
  doubled_numbers
end

puts double_odd_numbers(my_numbers)

def multiply(number, multiplier)
  counter = 0
  multiplied_number = []

  loop do 
      break if counter >= number.size
      multiplied_number << number[counter] * multiplier
      counter += 1
  end
  multiplied_number
end

puts multiply(my_numbers, 3)

# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# Input: string
# Output: array of strings
# Explicit Requirement
  # Finds and returns all substrings that are a palindrome in a larger string
  # Palindromes are case sensitive
# Implicit Requirements
  # Empty strings return empty arrays
  # Strings that do not have any palindromes return empty arrays


2
4, 6
8, 10, 12

Inputs: array of integers, integer (to represent the row)
Outputs: integer
Explicit Requirements
  Given an integer, use that to find the desired row
  Sum the row of numbers and return that number

Questions:
Does each row start at 2 or does it continue onto the next even integer?
Do the rows start at 1 or are they 0 indexed?
What to do if an integer is passed that is beyond the number of rows available?
What if someone passes in a string or non-int data type - how to handle?
Will the rows always contain even ints or could they contain strings, floats, etc.

