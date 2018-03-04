module GameHelper
  def start_game
    visit '/'
    fill_in "name", with: "David"
    click_button "Play!"
  end

  def set_player_hand(hand)
    page.set_rack_session(player_hand: hand)
    page.visit "/play-game"
  end

  def set_dealer_hand(hand)
    page.set_rack_session(dealer_hand: hand)
    page.visit "/play-game"
  end
end
