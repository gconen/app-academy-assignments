
class Code
  attr_accessor :secret_code

  def initialize
    @secret_code = ""
  end

  def create_code
    colors = %w(R G B Y O P)
    4.times do |n|
      self.secret_code += colors.sample
    end

    self
  end

  def exact_matches(other_code)
    matches = []
    4.times do |n|
      if self.secret_code[n] == other_code[n]
        matches << n
      end
    end

    matches
  end

  def code_arrays(other_code, matches)
    temp_sc = secret_code.chars
    temp_oc = other_code.chars

    matches.each do |pos|
      temp_sc[pos] = "not matching"
      temp_oc[pos] = "also not matching"
    end

    [temp_sc, temp_oc]
  end

  def near_matches(other_code, matches)
    temp_sc, temp_oc = code_arrays(other_code, matches)

    near_matches = []
    temp_oc.each do |element|
      near_matches << element if temp_sc.include?(element)
    end

    near_matches
  end
end

class Game
  attr_reader :code, :turn_number

  def initialize
    @code = Code.new.create_code
    @turn_number = 0
    @won = false
  end

  def take_turn
    puts "\nInput your guess"
    guess = gets.chomp.upcase
    exact_matches = code.exact_matches(guess)

    check_win(exact_matches)
    return if @won

    near_matches = code.near_matches(guess, exact_matches)
    puts "\nYou have #{exact_matches.count} exact matches"
    puts "and #{near_matches.count} near matches."
  end

  def check_win(exact_matches)
    if exact_matches.count == 4
      @won = true
    end
  end

  def play
    until over?
      @turn_number += 1
      puts "It is turn number #{turn_number}"
      take_turn
    end
  end

  def over?
    if @won
      puts "\nYou Win!"
      return true
    elsif @turn_number == 10
      puts "You Lose!"
      return true
    end
    return false
  end
end

new_game = Game.new
p new_game.code.secret_code
new_game.play
