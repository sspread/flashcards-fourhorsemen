## mikedaug seeds file


## => test code here...
# require 'bcrypt'
require 'faker'
require 'csv'

# def make_hashed_password
#   unhashed_password = "password"
#   BCrypt::Password.create(unhashed_password)
# end

# puts "Unhashed password: #{unhashed_password}"
# puts "hashed up password: #{some_hashed_password}"

# test_hash_1 = "$2a$10$ejcrEwPlijZ9tisvDrCNOuplKwbf7jnHzacPnrHwaBhdUqngDEweW"
# test_hash_2 = "$2a$10$.M8DNYqJPaun9/1A2neDHegPsdO.NpEj7CaxlEjl5o2gGvWFn.OUm"

########################################################################

## Create some users: user1 & user2, both with password as password...
hashes = ["$2a$10$ejcrEwPlijZ9tisvDrCNOuplKwbf7jnHzacPnrHwaBhdUqngDEweW", "$2a$10$.M8DNYqJPaun9/1A2neDHegPsdO.NpEj7CaxlEjl5o2gGvWFn.OUm"]
2.times do | count |
  User.create!(username: "user#{count}", password_hash: hashes[count])
end

########################## create cards ########################################
################################################################################

## get a list of file names (with and without the .filetype)
file_list = Array.new
file_list_clean = Array.new
Dir.foreach("db/csv_files") do |x|
  file_list << File.basename(File.absolute_path(x)) unless File.directory?(x)
  file_list_clean << File.basename(File.absolute_path(x), ".csv") unless File.directory?(x)
end

## go through the file list and for each row in a file create a card
# ActiveRecord::Base.transaction do
file_list.each_with_index do |file_name, index|
  CSV.foreach("db/csv_files/#{file_name}", :headers => true, :header_converters => :symbol) do |row|
    # Card.create!(question: row[:question], answer: row[:answer], deck_id: index + 1)
    
  end
end
# end


########################## create decks ########################################
################################################################################

file_list_clean.each { |file| Deck.create!(name: file) }

# ## create some rounds:
# Round.create!( user_id: 1, deck_id: 1, correct_count: 2, incorrect_count: 1)
# Round.create!( user_id: 1, deck_id: 2, correct_count: 1, incorrect_count: 2)
# Round.create!( user_id: 2, deck_id: 1, correct_count: 3, incorrect_count: 0)
# Round.create!( user_id: 2, deck_id: 2, correct_count: 0, incorrect_count: 3)
