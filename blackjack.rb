class Deck

  def initialize
    reset
    shuffle
  end

  def shuffle
    return @cards.shuffle
  end

  def draw
    return @cards.shift
  end

  def reset
    @cards = (0..51).to_a.map {|card_index| Card.new(card_index)}
  end
end

class Card
  attr_reader :value
  @@suits = {
    0 => :spades,
    1 => :hearts,
    2 => :diamonds,
    3 => :clubs
  }

  def initialize(card_index)
    @value = (card_index % 13) + 1
    @suit  = @@suits[card_index / 13]
  end

end

module Player

  attr_reader :cards, :bust, :value

  def initialize(table)
    reset
    @table = table
  end

  def value
    value = @cards.inject(0) do |value, card|
      value + @table.class.card_value(card.value)
    end
    count = num_aces
    while value > 21 && count > 0
      value -= 10
      count -= 1
    end
    value
  end

  def num_aces
    @cards.count {|card| card.value == 1}
  end

  def give(card)
    @cards << card
  end

  def reset
    @cards = []
  end

  def up_card
    cards.first.value
  end

end

class HumanPlayer
  include Player

  def take_turn
    if value > 21
      @bust = true
      return
    end
    puts "Dealer upcard is #{@table.dealer_up_card}"
    puts "Your value is #{value}; (H)it or (S)tand"
    if gets.chomp.downcase == "h"
      @table.give_card(self)
      take_turn
    end
  end
end


class Dealer
  include Player
  def take_turn
    if value > 21
      @bust = true
      return
    end
    while value < 17
      @table.give_card(self)
    end
  end
end


class BlackJack
  attr_accessor :player

  def initialize
    @player = HumanPlayer.new(self)
    @dealer = Dealer.new(self)
    @deck = Deck.new
  end

  def self.card_value(value)
    return value if value.between?(2,10)
    return 10 if value.between?(11,13)
    return 11 if value == 1
  end

  def deal
    2.times do
      give_card(@player)
      give_card(@dealer)
    end
  end

  def dealer_up_card
    @dealer.up_card
  end

  def give_card(player)
    player.cards << @deck.draw
  end

  def play_round
    @player.reset
    @dealer.reset
    deal
    @player.take_turn
    if @player.bust
      return @winner = :dealer
    end
    @dealer.take_turn
    if @dealer.bust || @player.value > @dealer.value
      @winner = :player
    elsif @player.value == @dealer.value
      @winner = :push
    else
      @winner = :player
    end
  end

  def play
    play_round
    puts @player.value
    puts @dealer.value
  end

end
