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
    @board.reveal_board
    @board.display
    # NR: Could lose..
    @elapsed_time += Time.now - @start_time
    puts "You took #{@elapsed_time.to_i} " +
         "seconds to #{@board.won ? 'win' : 'lose' }"
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
      if @board[*input].revealed
        puts "That is already revealed. Are you sure?"
        return if gets.chomp == 'n'
      end
      @board.flag_bomb(*input)
    else
      if @board[*input].flagged
        puts "That spot has a flag. Are you sure?"
        return if gets.chomp == 'n'
      end
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
