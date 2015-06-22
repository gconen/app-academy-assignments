class GuessingGame
  attr_reader :number

  def initialize
    @number = rand(1..100)
  end

  def guess?(guess_num)
    if guess_num == number
      puts "That's it exactly!"
      return true
    elsif guess_num < number
      puts "too low"
    else
      puts "too high"
    end
  end

  def prompt
    puts "Guess a number between 1 and 100:"
    Integer(gets)
  end

  def play
    loop do
      if guess?(prompt)
        puts "You win!"
        return
      end
    end
  end

end

game = GuessingGame.new
game.play
