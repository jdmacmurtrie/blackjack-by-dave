require "spec_helper"

RSpec.describe Card do
  describe ".new" do
    it "takes a value and suit" do
      new_card = Card.new("♦", 7)
      expect(new_card).to be_a(Card)
    end
  end

  let(:number_card) { FactoryBot.build(:card) }
  let(:face_card) { FactoryBot.build(:card, :facecard) }
  let(:ace_card) { FactoryBot.build(:card, :ace) }
  let(:heart) { FactoryBot.build(:card, :red) }

  describe "#value" do
    it "has a reader for the value" do
      expect(number_card.value).to eq(2)
    end
  end

  describe "#suit" do
    it "has a reader for the suit" do
      expect(number_card.suit).to eq("♠")
    end
  end

  describe "#facecard?" do
    it "returns true if card is K, Q, J, and false otherwise" do
      expect(face_card.facecard?).to be(true)
    end

    it "returns false if card is not King, Queen, or Jack" do
      expect(number_card.facecard?).to be(false)
    end
  end

  describe "#ace?" do
    it "it returns true if card is an ace, and false otherwise" do
      expect(ace_card.ace?).to be(true)
    end

    it "it returns false if card is not an ace" do
      expect(number_card.ace?).to be(false)
    end
  end

    describe "#red?" do
      it "it returns true if card is ♦ or ♥" do
        expect(heart.red?).to be(true)
      end

      it "returns false if card is ♣ or ♠" do
        expect(number_card.red?).to be(false)
      end
    end
  end

  # test
