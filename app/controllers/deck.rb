get '/decks' do
  @decks = Deck.all
  erb :'deck/deck'
end

get '/decks/:deck_id' do
  @round = Round.create(user_id: session[:user_id], deck_id: params[:deck_id])
  erb :'deck/card'
  # redirect "/decks/#{}"
end

post '/decks/:deck_id/cards/:card_id' do

end
