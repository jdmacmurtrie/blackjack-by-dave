require "spec_helper"

RSpec.describe Hand do
  describe ".new" do
    it "takes a set of new cards and a player" do
      new_hand = Hand.new([Card.new("♥", 5), Card.new("♥", "A")])
      expect(new_hand).to be_a(Hand)
    end
  end

  let(:deck) { FactoryBot.build(:deck) }
  let(:one_card) { FactoryBot.build(:card) }
  let(:facecard) { FactoryBot.build(:card, :facecard) }
  let(:ace) { FactoryBot.build(:card, :ace) }
  let(:normal_hand) { Hand.new(FactoryBot.build_list(:card, 2)) }
  let(:one_facecard) { Hand.new([one_card, facecard]) }
  let(:two_facecards) { Hand.new(FactoryBot.build_list(:card, 2, :facecard)) }
  let(:one_ace) { Hand.new([one_card, ace]) }
  let(:two_aces) { Hand.new(FactoryBot.build_list(:card, 2, :ace)) }
  let(:one_facecard_and_one_ace) { Hand.new([facecard, ace]) }

  describe "#calculate_hand" do
    it "calculates the total when dealt non-face cards or aces" do
      expect(normal_hand.calculate_hand).to eq(5)
    end

    it "calculates the total when dealt one facecard" do
      expect(one_facecard.calculate_hand).to eq(one_card.value + 10)
    end
    it "calculates the total when dealt two facecards" do
      expect(two_facecards.calculate_hand).to eq(20)
    end

    it "calculates the total when dealt an ace" do
      expect(one_ace.calculate_hand).to eq(one_card.value + 11)
    end

    it "calculates the total when dealt two aces" do
      expect(two_aces.calculate_hand).to eq(12)
    end

    it "calculates the total when dealt two aces" do
      expect(one_facecard_and_one_ace.calculate_hand).to eq(21)
    end
  end

  describe "#calculate_one" do
    it "calculates the visible dealers cards" do
      expect(normal_hand.calculate_one).to eq(normal_hand.cards.first.value)
    end
  end

  describe "#calculate_winner" do
    context "player wins" do
      it "declares the player the winner" do
        player = one_facecard_and_one_ace
        dealer = normal_hand
        expect(dealer.calculate_winner(player, dealer))
          .to eq "player"
      end
    end

    context "dealer wins" do
      it "declares the dealer the winner" do
        dealer = one_facecard_and_one_ace
        player = normal_hand
        expect(dealer.calculate_winner(player, dealer))
          .to eq "dealer"
      end
    end

    context "tie" do
      it "declares a push in case of tie" do
        player = two_facecards
        dealer = two_facecards
        expect(dealer.calculate_winner(player, dealer))
          .to eq "push"
      end
    end
  end

  describe "#hit" do
    it "adds one card to the player's hand" do
      normal_hand.hit(deck)
      expect(normal_hand.cards.size).to eq(3)
    end
  end

  describe "#check_bust" do
    it "checks to see if score is under 21" do
      one_ace.hit(deck)
      one_ace.check_bust
      expect(one_ace.bust).to be(false)
    end

    it "checks to see if score is over 21" do
      2.times { two_facecards.hit(deck) }
      two_facecards.check_bust
      expect(two_facecards.bust).to be(true)
    end
  end
end
