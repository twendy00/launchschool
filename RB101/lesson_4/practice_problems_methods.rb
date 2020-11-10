# 1. Turn this array into a hash where the names are the keys 
# and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = 
flintstones.each_with_object({}) do |num, hash|
  hash[flintstones.index(num)] = num
end

puts flintstones_hash

flintstones_hash_2 = {}
flintstones.each_with_index do |name, index|
  flintstones_hash_2[name] = index
end

puts flintstones_hash_2

# 2. Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

all_ages = ages.values
sum_of_ages = all_ages.sum
puts sum_of_ages

# 3. remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages_under_100 = 
ages.select do |key, value|
  value < 100
end

puts ages_under_100

# 4. Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

all_ages = ages.values
min_age = all_ages.min

puts min_age

ages.values.min

# 5. Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

be_name = ""
flintstones.each do |name|
  if name.start_with?("Be")
    be_name = name
  end
end

puts flintstones.index(be_name)

flintstones.index { |name| name[0, 2] == "Be" }

# 6. Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones_abbreviated = 
flintstones.map do |name|
  name[0, 3]
end

puts flintstones_abbreviated

# 7. Create a hash that expresses the frequency with which each letter occurs in this string:
statement = "The Flintstones Rock"
# counter = 0
letter_count = {}

# loop do
#   counter += 1
#   current_letter = statement[counter]
#   if current_letter == ' ' 
#     next
#   elsif letter_count.has_key?(current_letter)
#     letter_count[current_letter] += 1
#   else 
#     letter_count[current_letter] = 1
#   end
#   break if counter >= statement.size
# end

# puts letter_count
  
statement.chars.each do |letter|
  if letter == ' '
    next
  elsif letter_count.has_key?(letter)
    letter_count[letter] += 1
  else 
    letter_count[letter] = 1
  end
end

puts letter_count

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

puts result

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# 9. Create a string that has each word capitalized as it would be in a title
words = "the flintstones rock"

word = words.split

word.each do |w|
  w.capitalize!
end

new_word = word.join(" ")
p new_word

words.split.map { |word| word.capitalize }.join(' ')

# 10. Modify the hash such that each member of the Munster family has an 
# additional "age_group" key that has one of three values describing the 
# age group the family member is in (kid, adult, or senior). 
# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 
# and a senior is aged 65+.
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# munsters.each do |key, value|
#   munsters[key].each do |k, v|
#     munsters[key]["age_group"] = "adult"
#   end
#   puts value
# end


def categorize_age_group(a)
  if a >= 0 && a <= 17
    return "kid"
  elsif a <= 64
    return "adult"
  else
    return "senior"
  end
end

munsters.each do |key, value|
  age = munsters[key]["age"]
  age_group = categorize_age_group(age)
  munsters[key]["age_group"] = age_group
end

p munsters

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end