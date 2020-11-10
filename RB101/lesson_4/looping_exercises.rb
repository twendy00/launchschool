# Loop Exercises 1

# 1. Runaway Loop

loop do
  puts 'Just keep printing...'
  break
end

# 2. Loopception
loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break
  end

  break
end

puts 'This is outside all loops.'

# 3. Control the Loop
iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

# 4. Loop on Command
loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
  break if answer.downcase == 'yes'
end

# 5. Say Hello
say_hello = true
counter = 1

while say_hello
  puts 'Hello!'
  counter += 1
  say_hello = false if counter > 5
end

# 6. Print While
numbers = []

while numbers.size < 5
  numbers << rand(100)
end

puts numbers

# 7. Count Up
count = 1

until count > 10
  puts count
  count += 1
end

# 8. Print Until
# Use an until loop to print each number below. 
numbers = [7, 9, 13, 25, 18]
count = 0

until count >= numbers.size
  puts numbers[count]
  count += 1
end

# 9. That's Odd
for i in 1..100
  puts i if i.odd?
end

# 10. Greet Your Friends
friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}!"
end

# Loop Exercises 2

# 1. Even or Odd?
# Write a loop that prints numbers 1-5 and whether the number 
# is even or odd. Use the code below to get started.

count = 1

loop do
  break if count > 5
  puts "#{count} is odd!" if count.odd?
  puts "#{count} is even!" if count.even?
  count += 1
end

# 2. Catch the Number
# Modify the following code so that the loop 
# stops if number is equal to or between 0 and 10.
loop do
  number = rand(100)
  puts number
  break if number.between?(0, 10)
end

# 3. Conditional Loop
# Using an if/else statement, run a loop that prints 
# "The loop was processed!" one time if process_the_loop equals true. 
# Print "The loop wasn't processed!" if process_the_loop equals false.


loop do
  process_the_loop = [true, false].sample

  if process_the_loop
    puts "The loop was processed!"
  else 
    puts "The loop wasn't processed!"
  end

  puts "Do you want to keep going?"
  answer = gets.chomp
  break if answer.downcase == 'no'
end

# 4. Get the Sum
# The code below asks the user "What does 2 + 2 equal?" 
# and uses #gets to retrieve the user's answer. Modify 
# the code so "That's correct!" is printed and the loop 
# stops when the user's answer equals 4. Print "Wrong answer. 
# Try again!" if the user's answer doesn't equal 4.

loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
  if answer == 4
    puts "That's correct!"
    break
  end

  puts "wrong answer. Try again!"
end

# 5. Insert Numbers
# Modify the code below so that the user's input gets 
# added to the numbers array. Stop the loop when 
# the array contains 5 numbers.

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
  numbers << input
  break if numbers.size >= 5
end
puts numbers

# 6. Empty the Array
# Given the array below, use loop to remove and print each name. 
# Stop the loop once names doesn't contain any more elements.

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do 
  puts names.shift
  break if names.size == 0
end

# 7. Stop Counting
# The method below counts from 0 to 4. Modify the block so that 
# it prints the current number and stops iterating when the 
# current number equals 2.

5.times do |index|
  puts index
  break if index == 2
end

# 8. Only Even
# Using next, modify the code below so that it only prints even numbers.
number = 0

until number == 10
  number += 1
  next if number.odd?
  puts number
end

# 9. First to Five
# The following code increments number_a and number_b by either 0 or 1. 
# loop is used so that the variables can be incremented more than once, 
# however, break stops the loop after the first iteration. 
# Use next to modify the code so that the loop iterates until either 
# number_a or number_b equals 5. Print "5 was reached!" before breaking 
# out of the loop.

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)
  next unless number_a >= 5 || number_b >= 5
  
  puts "5 was reached" 
  break 
end

# 10. Greeting
# Given the code below, use a while loop to print "Hello!" twice.

def greeting
  puts 'Hello!'
end

number_of_greetings = 2

while number_of_greetings > 0
  greeting
  number_of_greetings -= 1
end