require_relative "card"

class Deck
  attr_reader :cards

  def initialize
    @cards = Card.suits.product(Card.values).map do |(suit, value)|
      Card.new(value, suit)
    end
  end

  def draw(num)
    raise ArgumentError.new("Deck out of cards") if num > @cards.count
    @cards.pop(num)
  end

  def shuffle
    @cards.shuffle!
  end

end
