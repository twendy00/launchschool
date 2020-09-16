puts "Welcome to the loan calculator!"
puts "We will calculate your monthly payment for your car loan or mortgage."

# Methods to validate user inputs
def input_valid(user_input)
  if /[[:digit:]]/.match(user_input)
    true
  else
    puts "Invalid input. Please enter a number greater than 0."
    false
  end
end

def input_not_neg(user_input)
  if user_input < 0
    puts "Only positive numbers are allowed. Please try again."
    false
  else
    true
  end
end

def input_not_zero(user_input)
  if user_input == 0
    puts "Input must be a number greater than 0. Please try again."
    false
  else
    true
  end
end

# Obtain & validate loan amount
loan_amount = ''
loop do
  puts "How much is your loan amount?"
  loan_amount = gets.chomp
   
  next unless input_valid(loan_amount)
  loan_amount = loan_amount.to_f
  next unless input_not_neg(loan_amount)
  next unless input_not_zero(loan_amount)
  break
end

# Obtain & validate APR
apr_percent = ''
loop do
  puts "What is the APR% on your loan?"
  apr_percent = gets.chomp

  next unless input_valid(apr_percent)
  apr_percent = apr_percent.to_f
  next unless input_not_neg(apr_percent)
  break
end

# Obtain & validate loan duration
loan_term_months = ''
loop do
  loan_term_years = ''
  remaining_loan_term_months = ''

  loop do
    puts "How many years do you have on your loan?"
    loan_term_years = gets.chomp

    next unless input_valid(loan_term_years)
    loan_term_years = loan_term_years.to_f
    next unless input_not_neg(loan_term_years)
    break
  end

  loop do
    puts "How many months do you have on your loan?"
    remaining_loan_term_months = gets.chomp

    next unless input_valid(remaining_loan_term_months)
    remaining_loan_term_months = remaining_loan_term_months.to_f
    next unless input_not_neg(remaining_loan_term_months)
    break
  end

  loan_term_years_to_months = loan_term_years * 12
  loan_term_months = loan_term_years_to_months + remaining_loan_term_months

  if loan_term_months == 0
    puts "Your loan duration must be at least 1 month. Please try again."
  else
    break
  end
end

# Calculate monthly payment
apr_decimal = apr_percent / 100
monthly_interest_rate = apr_decimal / 12
monthly_payment = (loan_amount * (monthly_interest_rate / 
                  (1 - (1 + monthly_interest_rate)**(-loan_term_months)))
monthly_payment = monthly_payment.round(2)

puts "Loan Amount: $#{loan_amount}"
puts "Monthly Interest Rate: #{monthly_interest_rate * 100}%"
puts "Loan Duration in Months: #{loan_term_months}"
puts "Monthly Payment: $#{monthly_payment}"

puts "You will have a monthly payment of $#{monthly_payment}."
puts "Good-bye!"
