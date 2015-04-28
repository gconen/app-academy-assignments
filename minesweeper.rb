require "yaml"
require_relative "minesweeper_tile.rb"
require_relative "minesweeper_board.rb"

class Game
  attr_writer :start_time

  def initialize
    @board = Board.new
    @start_time = Time.now
    @elapsed_time = 0
  end

  def play
    until @board.over?
      @board.display
      turn
    end
    @board.display
    @elapsed_time += Time.now - @start_time
    puts "You took #{@elapsed_time.to_i} seconds to win"
  end

  def prompt_input
    puts "Give us a coordinate, or (S) for (s)ave:"
    input = gets.chomp
    if input.downcase == "s"
      save
      exit
    end

    input = input.split(/[, ]/)
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

  def self.load(filename)
    game = YAML::load_file(filename)
    game.start_time = Time.now
    File.delete(filename)
    game
  end

  def save(filename = "save.yml")
    @elapsed_time += Time.now - @start_time
    File.open(filename, 'w') do |f|
      f.puts self.to_yaml
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  if File.exist?("save.yml")
    Game.load("save.yml").play
  else
    Game.new.play
  end
end
