require_relative 'board.rb'
require_relative 'cursor_player.rb'

class Game
  attr_reader :board, :game

  def initialize(red = nil, white = nil)
    @board = Board.new
    red ||= Player.new(:red)
    white ||= Player.new(:white)
    @players = { red: red, white: white}
    @turn = :red
    @board.place_starting_pieces
  end

  def play
    until @board.winner
      take_turn
      @turn = @turn == :red ? :white : :red
    end
    puts "#{@board.winner} wins!".capitalize

    nil
  end

  def take_turn
    begin
      move = @players[@turn].get_move(@board.deep_dup)
      p move
      start_location, move_sequence = move
      p start_location
      p move_sequence
      @board.do_move(start_location, move_sequence, @turn)
    rescue IllegalMoveError => e
      puts e.message
      retry
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(CursorPlayer.new(:red), CursorPlayer.new(:red))
  g.play
end
