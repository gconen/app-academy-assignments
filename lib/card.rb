class Card
  SUITS = [:hearts, :diamonds, :clubs, :spades]
  VALUES = {
    ace: 14,
    king: 13,
    queen: 12,
    jack: 11,
    ten: 10,
    nine: 9,
    eight: 8,
    seven: 7,
    six: 6,
    five: 5,
    four: 4,
    three: 3,
    two: 2
  }

  def self.suits
    SUITS
  end

  def self.values
    VALUES.keys
  end

  attr_reader :suit, :value

  def initialize(value, suit)
    unless Card.values.include?(value) && Card.suits.include?(suit)
      raise ArgumentError.new("Card parameters not valid")
    end
    @value = value
    @suit = suit
  end

  def ==(other)
    return false unless other.is_a?(Card)
    other.suit == @suit && other.value == @value
  end

  def <=>(b)
    VALUES[@value] <=> VALUES[b.value]
  end
end
