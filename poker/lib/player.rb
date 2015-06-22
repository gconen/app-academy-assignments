class Player # computer player
  attr_accessor :hand
  attr_reader :bankroll

  def initialize(bankroll)
    @bankroll = bankroll
  end

  def start_new_round(hand)
    @pot_contribution = 0
    @hand = hand
  end

  def make_move(pot_per_person)
    puts available_options
    input = gets.chomp.to_sym
    if [:call, :check, :raise, :fold].include?(input)
      self.send(input, pot_per_person)
    end
  rescue InputError => e
    puts e.message
    retry
  end

  def check(pot_per_person)
    unless pot_per_person == @pot_contribution
      raise InputError, "You haven't paid enough to check."
    end
    :check
  end

  def call(pot_per_person)
    contribution = pot_per_person - @pot_contribution
    if contribution > @bankroll
      raise InputError, "You cannot afford to call."
    end
    @bankroll -= contribution
    @pot_contribution = pot_per_person
    :call
  end

  def fold(pot_per_person)
    if @pot_contribution == pot_per_person
      raise InputError, "You lose literally nothing by continuing to play."
    end
    :fold
  end

  def make_raise(pot_per_person)
    print "Raise amount: "
    raise_amount = Integer(gets.chomp)
    contribution = pot_per_person + raise_amount - @pot_contribution
    if contribution > @bankroll
      raise InputError, "You cannot afford to raise."
    end
    @bankroll -= contribution
    pot_per_person = pot_per_person + raise_amount
    @pot_contribution = pot_per_person
    contribution
  end

  def ante(amount)
    puts "Ante is #{amount}. Buy in?"
    result = gets.chomp
    return :fold if result == "n"
    @bankroll -= amount
    return :pay
  end
end
