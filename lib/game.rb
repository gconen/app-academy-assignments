class Game
  attr_reader :players, :deck, :pot
  attr_accessor :pot_per

  def initialize(*players)
    @players = players
    @deck = Deck.new
    @deck.shuffle
  end

  def run_hand
    @pot_per = 0
    @pot = 0
    @active_players = @players
    # players ante
    # deal hands
    # betting round
    # discard
    # betting round
    # determine winner and pay bets
  end

  def betting_round
    until #
      input = @players.first.make_move(@pot_per)
      if input.is_a?(Fixnum)
        do_raise(input)
      else
        self.send(input)
      end


  end

  def do_raise(contribution)
    @pot += contribution

    @pot_per

  end
end
