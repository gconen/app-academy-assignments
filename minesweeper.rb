require_relative "minesweeper_tile.rb"
require_relative "minesweeper_board.rb"

class Game

  # attr_reader :board #testing only!

  def initialize
    @board = Board.new
  end

  def play
    until @board.over?
      @board.display
      turn
    end
    @board.display
  end

  def prompt_input
    puts "Give us a coordinate"
    input = gets.chomp.split(/[, ]/)
    input.map! {|el| Integer(el)}
  end

  def turn
    input = prompt_input
    puts "Place a (f)lag or (r)eveal a square"
    if gets.chomp.downcase == 'f'
      @board.flag_bomb(*input)
    else
      @board.reveal(*input)
    end
  end
end
