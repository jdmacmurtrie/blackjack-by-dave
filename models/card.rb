class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def facecard?
    %w{K Q J}.include? @value
  end

  def ace?
    @value == "A"
  end

  def red?
    %w{♦ ♥}.include? @suit
  end
end

# test
