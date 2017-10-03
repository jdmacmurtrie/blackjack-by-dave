class Hand
  attr_reader :cards
  attr_accessor :bust
  def initialize(cards)
    @cards = cards
    @bust = false
  end

  def calculate_hand
    total = 0
    ace_count = 0
    @cards.each do |card|
      if card.facecard?
        total += 10
      elsif card.ace?
        total += 1
        ace_count += 1
      else
        total += card.value
      end
    end
    if ace_count > 0 && total + 10 <= 21
      total += 10
    end
    total
  end

  def calculate_one
    total = 0
    @first_card = @cards[0]
    if @first_card.facecard?
      total += 10
    elsif @first_card.ace?
      total += 1
    else
      total += @first_card.value
    end
    total
  end

  def calculate_winner(player, dealer)
    if player.calculate_hand == dealer.calculate_hand
      'push'
    elsif player.calculate_hand > dealer.calculate_hand
      'player'
    else
      'dealer'
    end
  end
  # def dealer_hand
  #   puts "\n#{@player}\'s visible hand:"
  #   puts "#{@cards.first.value} of #{@cards.first.suit}"
  # end

  # def show_hand
  #   @cards.each do |card|
  #     puts "#{@player} was dealt a #{card.value} of #{card.suit}"
  #     sleep(1)
  #   end
  #   puts "Total: #{calculate_hand}\n"
  # end

  def hit(deck)
    new_card = deck.deal!(1)
    @cards << new_card[0]
    # sleep(1)
    # puts "#{@player} receives a #{new_card[0].value} of #{new_card[0].suit}"
    # puts "Total: #{calculate_hand}\n"
  end

  def check_bust
    if calculate_hand > 21
      @bust = true
      # puts "Bust! #{@player} loses."
    end
  end
end
