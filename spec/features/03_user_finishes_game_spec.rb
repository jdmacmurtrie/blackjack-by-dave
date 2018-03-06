require 'spec_helper'

feature 'user finishes game' do

  let(:busted_hand) { Hand.new(FactoryBot.build_list(:card, 3, :facecard)) }

  before(:each) do
    start_game
    set_player_hand(busted_hand)
    find('button', class: 'hit').click
  end

  scenario 'user chooses to play again' do
    find('button', class: 'yes').click

    expect(page.find_by_id('player-cards')).to have_selector('.card', count: 2)
    expect(page).to have_button "Hit"
    expect(page).to_not have_button "Yes"
    expect(page.current_path).to eq('/play-game')
  end

  scenario 'user chooses not to play again' do
    find('button', class: 'no').click

    expect(page).to have_text("Welcome to Blackjack")
    expect(page.current_path).to eq('/new-game')
  end
end
