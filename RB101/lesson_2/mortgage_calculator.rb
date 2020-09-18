require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("#{message}")
end

# Methods to validate user inputs
def input_valid?(user_input)
  if /[[:digit:]]/.match(user_input)
    true
  else
    prompt('invalid_input')
    false
  end
end

def input_neg?(user_input)
  if user_input < 0
    prompt('only_positive')
    false
  else
    true
  end
end

def input_nonzero?(user_input)
  if user_input == 0
    prompt('only_nonzero')
    false
  else
    true
  end
end

def is_integer?(user_input)
  if user_input.to_i.to_s == user_input
    return true
  else
    prompt('only_whole_num')
    false
  end
end

def valid_12_months?(user_input)
  if user_input > 12
    prompt('valid_12_months')
    false
  else
    true
  end
end

# Obtain & validate loan amount
def get_loan_amount
  loan_amount = 0
  loop do
    prompt('get_loan_amount')
    loan_amount = gets.chomp
  
    next unless input_valid?(loan_amount)
    loan_amount = loan_amount.to_f
    next unless input_neg?(loan_amount)
    next unless input_nonzero?(loan_amount)
    break
  end
  loan_amount
end

# Obtain & validate apr 
def get_apr
  monthly_interest_rate = 0
  loop do
    prompt('get_apr')
    apr_percent = gets.chomp

    next unless input_valid?(apr_percent)
    apr_percent = apr_percent.to_f
    next unless input_neg?(apr_percent)
    next unless input_nonzero?(apr_percent)
    apr_decimal = apr_percent / 100
    monthly_interest_rate = (apr_decimal / 12)
    break
  end
  monthly_interest_rate
end

# Obtain & validate loan term in years
def get_loan_term_years
  loan_term_years = 0
  loop do
    prompt('get_loan_years')
    loan_term_years = gets.chomp

    next unless input_valid?(loan_term_years)
    next unless is_integer?(loan_term_years)
    loan_term_years = loan_term_years.to_i
    next unless input_neg?(loan_term_years)
    break
  end
  loan_term_years
end

# Obtain & validate loan term in months
def get_loan_term_months
  loan_term_months = 0
  loop do
    prompt('get_loan_months')
    loan_term_months = gets.chomp

    next unless input_valid?(loan_term_months)
    next unless is_integer?(loan_term_months)
    loan_term_months = loan_term_months.to_i
    next unless input_neg?(loan_term_months)
    next unless valid_12_months?(loan_term_months)
    break
  end
  loan_term_months
end

# Calculate & validate loan duration
def get_loan_duration()
  total_loan_term_months = 0
  loop do
    loan_term_years = get_loan_term_years()
    loan_term_months = get_loan_term_months()
    total_loan_term_months = (loan_term_years * 12) + loan_term_months

    if total_loan_term_months == 0
      prompt('invalid_loan_term')
    else
      break
    end
  end
  total_loan_term_months
end

# Calculate monthly payment
def calc_monthly_payment(loan_amount, monthly_interest_rate, loan_term_months)
  monthly_payment = (loan_amount * (monthly_interest_rate / 
                    (1 - (1 + monthly_interest_rate)**(-loan_term_months))))
  monthly_payment = monthly_payment.round(2)
end

def perform_calc_again
  loop do
    perform_calc_again = gets.chomp.downcase

    if perform_calc_again == 'n'
      return false
    elsif perform_calc_again == 'y'
      return true
    else
      prompt('invalid_calc_again')
    end
  end
end

# Execute
prompt('welcome')
prompt ('program_desc')

loop do 
  loan_amount = get_loan_amount()
  monthly_interest_rate = get_apr()
  loan_term_months = get_loan_duration()
  monthly_payment = calc_monthly_payment(loan_amount, monthly_interest_rate, loan_term_months)


  puts "Loan Amount: $#{loan_amount}"
  puts "Monthly Interest Rate: #{(monthly_interest_rate * 100).round(2)}%"
  puts "Loan Duration in Months: #{loan_term_months}"
  puts "Monthly Payment: $#{monthly_payment}"
  puts "You will have a monthly payment of $#{monthly_payment}."

  prompt('perform_calc_again')
  break unless perform_calc_again()
end
prompt('bye')
