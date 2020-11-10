# 1. How would you order this array of number strings by descending numeric value?
arr = ['10', '11', '9', '7', '8']

# sorted_arr = 
#   arr.sort_by do |element|
#     element.to_i
#   end

# p sorted_arr

sorted_arr_desc = 
  arr.sort do |a, b|
    b.to_i <=> a.to_i
  end

#  p sorted_arr_desc

# 2. How would you order this array of hashes based on the year of 
# publication of each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

sorted_books = 
  books.sort_by do |book|
    book[:published]
  end

# p sorted_books

# 3. For each of these collection objects demonstrate how you would reference the letter 'g'.
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0] 

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].keys[0]
hsh2[:third].key(0)

# 4. For each of these collection objects where the value 3 occurs, 
# demonstrate how you would change this to 4.
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[["a"]][:a][2] = 4

# 5. Figure out the total age of just the male members of the family.
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

male_members = 
  munsters.select do |key, value|
    value["gender"] == "male"
  end

male_members_age = 
  male_members.map do |key, value|
    value["age"] 
  end

#  p male_members_age.sum

male_members_age_2 = 
  male_members.map do |key, value|
    munsters.select do |key, value|
      value["gender"] == "male"
    end
    value["age"]
  end

# p male_members_age_2

total_male_age = 0
munsters.each_value do |details|
  total_male_age += details["age"] if details["gender"] == "male"
end

# p total_male_age

# 6. One of the most frequently used real-world string properties is that of "string substitution", 
# where we take a hard-coded string and modify it with various parameters from our program.
# Given this previously seen family hash, print out the name, age and gender of each family member:
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# ... like this: 
# (Name) is a (age)-year-old (male or female).

munsters.each do |key, value|
  puts "#{key} is a #{value["age"]}-year-old #{value["gender"]}."
end

# 7. Given this code, what would be the final values of a and b? 
# Try to work this out without running the code.
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# 8. Using the each method, write some code to output all of the vowels from the strings.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'AEIOUaeiou'
hsh.each do |key, value| # if we don't use key, remember to use underscore instead
  value.each do |word|
    characters = word.chars
    characters.each do |char|
      p char if vowels.include? char
    end
  end
end

vowels = 'aeiou'

hsh.each do |_, value|
  value.each do |str|
    str.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end

# 9. Given this data structure, return a new array of the same structure but with the sub arrays 
# being ordered (alphabetically or numerically as appropriate) in descending order.
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted_arr = 
arr.map do |a|
  a.sort do |a, b|
    b <=> a
  end
end

p sorted_arr

# 10. Given the following data structure and without modifying the original array, 
# use the map method to return a new array identical in structure to the original 
# but where the value of each integer is incremented by 1.
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_hash = 
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
  hash.each do |key, value|
    hash[key] = value + 1
  end
end

p new_hash

new_hash_2 = 
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end

p new_hash_2

# 11. Given the following data structure use a combination of methods, 
# including either the select or reject method, to return a new array
# identical in structure to the original but containing only the integers 
# that are multiples of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

new_arr = 
arr.map do |a|
  a.select do |element|
    element % 3 == 0
  end
end

p new_arr

# 12. Given the following data structure, and without using the 
# Array#to_h method, write some code that will return a hash where 
# the key is the first item in each sub array and the value is the 
# second item.
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

hsh = {}
arr.map do |a| # should use each method if don't want to return anything new from map
  hsh[a[0]] = a[1]
end

p hsh

# 13. Given the following data structure, return a new array containing the
# same sub-arrays as the original but ordered logically by only taking into 
# consideration the odd numbers they contain.
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# The sorted array should look like this: [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

sorted_arr = 
arr.sort_by do |sub_arr|
  sub_arr.select do |num|
    num.odd?
  end
end

# p sorted_arr

# 14. Given this data structure write some code to return an array containing 
# the colors of the fruits and the sizes of the vegetables. The sizes should 
# be uppercase and the colors should be capitalized.
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}
# The return value should look like:
[["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

produce_hsh =  
hsh.map do |_, value|
  if value[:type] == 'fruit'
    value[:colors].map do |color|
      color.capitalize
    end
  else # or elsif value[:type] == 'vegetable'
    value[:size].upcase
  end
end

# p produce_hsh

# 15. Given this data structure write some code to return an array which 
# contains only the hashes where all the integers are even.
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# new_hash = {}
# new_arr = []

# arr.each do |hash|
#   hash.map do |key, value|
#     new_value_arr = 
#     value.select do |num|
#       num.even?
#     end
#     new_hash[key] = new_value_arr
#   end
# end

# new_arr << new_hash
# p new_arr

even_arr = 
arr.select do |hash|
  hash.all? do |key, value|
    value.all? do |num|
      num.even?
    end
  end
end

p even_arr

# 16. Each UUID consists of 32 hexadecimal characters, and is typically 
# broken into 5 sections like this 8-4-4-4-12 and represented as a string.
# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"
# Write a method that returns one UUID when called with no parameters.


def return_uuid
  characters = 'abcdef0123456789'
  sections = [8, 4, 4, 4, 12]
  index = 0
  uuid = ""

  loop do 
    counter = 0
    loop do
      rand_char = characters[rand(characters.size)]
      uuid.concat(rand_char)
      counter += 1
      break if counter >= sections[index]
    end
    index += 1
    break if index >= sections.size
    uuid.concat("-")
  end
  uuid
end

puts return_uuid

def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end