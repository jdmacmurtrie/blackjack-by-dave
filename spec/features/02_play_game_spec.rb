require "spec_helper"

feature "user plays game" do

  before(:each) do
    start_game
  end

  let(:facecard) { FactoryBot.build(:card, :facecard) }
  let(:ace) { FactoryBot.build(:card, :ace) }
  let(:low_hand) { Hand.new(FactoryBot.build_list(:card, 2)) }
  let(:high_hand) { Hand.new(FactoryBot.build_list(:card, 2, :nine)) }
  let(:two_facecards) { Hand.new(FactoryBot.build_list(:card, 2, :facecard)) }
  let(:blackjack) { Hand.new([facecard, ace]) }
  let(:busted_hand) { Hand.new(FactoryBot.build_list(:card, 3, :facecard)) }

  scenario "user sees cards and hits" do
    set_player_hand(low_hand)
    set_dealer_hand(two_facecards)

    expect(page).to have_text("Score: 5")
    expect(page).to have_text("Score: 10")

    find('button', class: 'hit').click
    total_score = page.get_rack_session['player_hand'].calculate_hand
    page.visit "/play-game"

    expect(page.find('div', id: 'player-cards')).to have_selector('.card', count: 3)
    expect(page).to have_text("Score: #{total_score}")
  end

  scenario "user sees cards and stands" do
    find('button', class: 'stand').click

    expect(page.find_by_id('player-cards')).to have_selector('.card', count: 2)
  end

  scenario "user busts" do
    set_player_hand(busted_hand)
    find('button', class: 'hit').click

    expect(page).to have_text("Bust!")
    expect(page).to have_text("David loses. Play again?")
    expect(page).to have_button("Yes")
    expect(page).to have_button("No")
  end

  scenario "user gets Blackjack" do
    set_player_hand(blackjack)

    expect(page).to have_text("You got Blackjack!")
    expect(page).to have_button("Dealer's Turn")
  end

  scenario "user stands and dealer busts" do
    set_dealer_hand(busted_hand)
    find('button', class: 'stand').click

    expect(page).to have_text("Bust!")
    expect(page).to have_text("David wins! Play again?")
  end

  scenario "user stands and dealer wins" do
    set_player_hand(low_hand)
    set_dealer_hand(blackjack)
    find('button', class: 'stand').click

    expect(page).to have_text("David loses. Play again?")
  end

  scenario "user wins" do
    set_player_hand(two_facecards)
    set_dealer_hand(high_hand)
    click_button "Stand"

    expect(page).to have_text("David wins! Play again?")
  end

  scenario "user and dealer push" do
    set_player_hand(two_facecards)
    set_dealer_hand(two_facecards)
    click_button "Stand"

    expect(page).to have_text("Push! No winner. Play again?")
  end
end

# test
