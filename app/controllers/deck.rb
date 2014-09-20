get '/decks' do
  @decks = Deck.all
  erb :'deck/deck'
end

get '/decks/:deck_id' do

  round = Round.create(user_id: session[:user_id], deck_id: params[:deck_id])
  session[:round_id] = round.id
  session[:card_index] = 0
  session[:card_ids_arr] = round.deck.card_ids
  erb :'deck/card'
  # redirect "/decks/#{}"
end

post '/decks/cards' do
  if session[:card_index] < session[:card_ids_arr].length-1
    round = Round.find(session[:round_id])
    card = Card.find(session[:card_ids_arr][session[:card_index]])
    @guess = params[:guess]
    if card.answer == params[:guess]
      @correct = "right"
      round.correct_count += 1
      round.save
    else
      @correct = "dead wrong"
      round.incorrect_count += 1
      round.save
    end
    session[:card_index] += 1
    erb :'deck/card'
  else
    erb :'users/profile'
  end
end
