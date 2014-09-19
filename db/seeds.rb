## mikedaug seeds file


## => test code here...
# require 'bcrypt'
require 'faker'

# def make_hashed_password
#   unhashed_password = "password"
#   BCrypt::Password.create(unhashed_password)
# end

# puts "Unhashed password: #{unhashed_password}"
# puts "hashed up password: #{some_hashed_password}"

# test_hash_1 = "$2a$10$ejcrEwPlijZ9tisvDrCNOuplKwbf7jnHzacPnrHwaBhdUqngDEweW"
# test_hash_2 = "$2a$10$.M8DNYqJPaun9/1A2neDHegPsdO.NpEj7CaxlEjl5o2gGvWFn.OUm"

########################################################################

## Create some users:
hashes = ["$2a$10$ejcrEwPlijZ9tisvDrCNOuplKwbf7jnHzacPnrHwaBhdUqngDEweW", "$2a$10$.M8DNYqJPaun9/1A2neDHegPsdO.NpEj7CaxlEjl5o2gGvWFn.OUm"]
2.times do | count |
  User.create!(username: Faker::Name.last_name, password_hash: hashes[count])
end

## create some cards deck one
questions1 = ["Who was the first president?", "Who was the second President?", "Who was the third President?"]
answers1 = ["George Washington", "John Adams", "Thomas Jefferson"]
3.times do |index|
  Card.create!(question: questions1[index], answer: answers1[index], deck_id: 1)
end

## create some cards deck two
questions2 = ["Who was the first Vice President?", "Who was the second Vice President?", "Who was the third Vice President?"]
answers2 = ["John Adams", "Thomas Jefferson", "Aaron Burr"]

3.times do |index|
  Card.create!(question: questions2[index], answer: answers2[index], deck_id: 2)
end


## create some decks:
deck_names= ["US Presidents", "US Vice Presidents"]
deck_names.each { |name| 
  Deck.create!( name: name )
}

## create some rounds:
Round.create!( user_id: 1, deck_id: 1, correct_count: 2, incorrect_count: 1)
Round.create!( user_id: 1, deck_id: 2, correct_count: 1, incorrect_count: 2)
Round.create!( user_id: 2, deck_id: 1, correct_count: 3, incorrect_count: 0)
Round.create!( user_id: 2, deck_id: 2, correct_count: 0, incorrect_count: 3)

