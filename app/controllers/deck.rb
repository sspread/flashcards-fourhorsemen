get '/decks' do
  @decks = Deck.all
  erb :'deck/deck'
end

get '/decks/:deck_id' do
  @round = Round.create(user_id: session[:user_id], deck_id: params[:deck_id])
  session[:round_id] = @round.id
  session[:card_index] = 0

  # session[:card_ids_arr] = round.deck.card_ids
  erb :'deck/card'
end

get '/quit' do

  erb :'users/profile'
end

post '/decks/cards' do 
  @round = Round.find(session[:round_id])
  card = Card.find(@round.deck.card_ids[session[:card_index]])
  @guess = params[:guess]
  if card.answer == params[:guess]
    @correct = "right"
    @round.correct_count += 1
    @round.save
  else
    @correct = "dead wrong"
    @round.incorrect_count += 1
    @round.save
  end
  if session[:card_index] < @round.deck.card_ids.length-1
    session[:card_index] += 1
    erb :'deck/card'
  else
    redirect '/users/profile'
  end
end
