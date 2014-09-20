require 'faker'
require 'csv'

## Create some users: user1 & user2, both with password as password...
########################################################################
hashes = [
  "$2a$10$ejcrEwPlijZ9tisvDrCNOuplKwbf7jnHzacPnrHwaBhdUqngDEweW", 
  "$2a$10$.M8DNYqJPaun9/1A2neDHegPsdO.NpEj7CaxlEjl5o2gGvWFn.OUm"
]
(hashes.size).times do | count |
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
start_time = Time.now
ActiveRecord::Base.transaction do
  file_list.each_with_index do |file_name, index|
    CSV.foreach("db/csv_files/#{file_name}", :headers => true, :header_converters => :symbol) do |row|
      Card.connection.execute "INSERT INTO cards (question, answer, deck_id) VALUES ('#{row[:question]}', '#{row[:answer]}', '#{index + 1}')"
    end
  end
end
end_time = Time.new - start_time

########################## create decks ########################################
################################################################################
file_list_clean.each { |file| Deck.create!(name: file) }


########################## create rounds #######################################
################################################################################
Round.create!( user_id: 1, deck_id: 1, correct_count: 10, incorrect_count: 5)
Round.create!( user_id: 1, deck_id: 2, correct_count: 10, incorrect_count: 2)
Round.create!( user_id: 2, deck_id: 1, correct_count: 5, incorrect_count: 10)
Round.create!( user_id: 2, deck_id: 2, correct_count: 10, incorrect_count: 0)
