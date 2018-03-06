require "spec_helper"

feature 'user starts game' do
  scenario 'user inputs name to start game' do
    visit '/'

    expect(page).to have_text("Welcome to Blackjack")
    expect(page).to have_text("Please enter your name:")

    fill_in "name", with: "David"
    click_button "Play!"

    expect(page.current_path).to eq("/play-game")
    expect(page.find_by_id('player-cards')).to have_selector('.card', count: 2)
    expect(page.find_by_id('dealer-cards')).to have_selector('.card', count: 2)
    expect(page).to have_button "Hit"
    expect(page).to have_button "Stand"
  end

  scenario 'user tries to start game without name' do
    visit '/'

    click_button "Play"

    expect(page).to have_text "Enter a name to play the game"
  end
end

# test
