require_relative 'card'

class Hand
  HANDS = [

  ]

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def draw(deck)
    @cards.concat(deck.draw(5))
  end

  def beats?(other_hand)
    return ranking > other_hand.ranking unless ranking == other_hand.ranking
    if ranking < 2

    end

    higher_card?(other_hand)
  end

  protected
  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    Card.values.any? do |value|
      4 == @cards.count {|card| card.value == value }
    end
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    Card.suits.any? do |suit|
      @cards.all? { |card| card.suit == suit }
    end
  end

  def straight?
    card_rankings = @cards.sort.map { |card| Card::VALUES[card.value] }
    (card_rankings.first..card_rankings.last).to_a == card_rankings
  end

  def three_of_a_kind?
    Card.values.any? do |value|
      3 == @cards.count {|card| card.value == value }
    end
  end

  def two_pairs?
    2 == Card.values.count do |value|
      2 == @cards.count {|card| card.value == value }
    end
  end

  def pair?
    Card.values.any? do |value|
      2 == @cards.count {|card| card.value == value }
    end
  end

  def ranking
    return 7 if straight_flush?
    return 6 if four_of_a_kind?
    return 5 if full_house?
    return 4 if flush?
    return 3 if straight?
    return 2 if three_of_a_kind?
    return 1 if two_pairs?
    return 0 if pair?
    -1
  end

  def higher_card?(other_hand)
    sorted_cards = @cards.sort
    sorted_other = other_hand.cards.sort

    until sorted_cards.empty?
      spaceship = sorted_cards.pop <=> sorted_other.pop
      return false if spaceship == -1
      return true if spaceship == 1
    end

    false
  end
end
