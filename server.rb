require 'sinatra'
require 'pry'
require_relative 'models/card'
require_relative 'models/hand'
require_relative 'models/deck'

set :bind, '0.0.0.0'  # bind to all interfaces

enable :sessions

get '/' do
  redirect '/new-game'
end

get '/new-game' do
  if session[:name]
    session[:player_hand] = Hand.new(session[:deck].deal!(2))
    session[:dealer_hand] = Hand.new(session[:deck].deal!(2))
    session[:turn] = 'player'
    redirect '/play-game'
  else
    erb :new_game
  end
end

get '/play-game' do
  if session[:turn] == 'player'
    session[:name]
    @dealer_hand = session[:dealer_hand].cards[0]
    session[:player_score] = session[:player_hand].calculate_hand
    session[:dealer_score] = session[:dealer_hand].calculate_one
    if session[:player_hand].calculate_hand == 21
      session[:turn] = "dealer"
      session[:blackjack] = true
      binding.pry
    end
  else
    session[:dealer_score] = session[:dealer_hand].calculate_hand
  end
  erb :play_game
end

post '/play-game' do
  session[:turn] = 'player'
  session[:name] = params['name']
  session[:deck] = Deck.new
  session[:player_hand] = Hand.new(session[:deck].deal!(2))
  session[:dealer_hand] = Hand.new(session[:deck].deal!(2))
  redirect '/play-game'
end

post '/play-game/hit' do
  session[:name]
  session[:player_hand].hit(session[:deck])
  session[:player_score] = session[:player_hand].calculate_hand
  if session[:player_hand].check_bust
    session[:bust] = session[:name]
  end

  if session[:player_hand].calculate_hand == 21
    session[:blackjack] = true
    session[:turn] = "dealer"
  end
  redirect '/play-game'
end

post '/play-game/dealer-turn' do
  session[:turn] = 'dealer'
  session[:dealer_hand]
  session[:dealer_score]

  while session[:dealer_hand].calculate_hand <= 17 && !session[:dealer_hand].bust
    session[:dealer_hand].hit(session[:deck])
  end
  if session[:dealer_hand].check_bust
    session[:bust] = 'Dealer'
  else
    session[:winner] = session[:dealer_hand].calculate_winner(session[:player_hand], session[:dealer_hand])
  end
  redirect 'play-game'
end

post '/new-game' do
  session[:bust] = nil
  session[:winner] = nil
  session[:blackjack] = nil
  if params.keys == ['yes']
    session[:name]
    redirect '/new-game'
  else
    session[:name] = nil
    redirect '/new-game'
  end
end
