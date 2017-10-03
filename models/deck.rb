class Deck
  SUITS = ['♦', '♣', '♠', '♥']
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  attr_reader :cards
  def initialize(a_few_cards = nil)
    if !a_few_cards.nil?
      @cards = a_few_cards
    else
      @cards = make_deck
    end
  end

  def make_deck
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards.shuffle!
  end

  def deal!(number_of_cards)
    cards.pop(number_of_cards)
  end
end
