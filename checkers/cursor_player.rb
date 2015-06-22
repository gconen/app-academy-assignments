require 'io/console'
require_relative 'array_patch.rb'
require_relative 'player.rb'

class CursorPlayer < Player
  attr_writer :board

  def get_piece
    @board.cursor = [0, 0]
    input = get_coords("Select a piece.")
    if input.last? == :stop
      @board.selected_squares << input[0]
    else
      @board.selected_squares << input[0]
    end

    input
  end

  def get_sequence
    sequence = []
    loop do
      input = get_coords("Choose a move")
      if input[1] == :stop
        sequence << input[0] unless sequence.last == input.first
      sequence << input
      @board.selected_squares << input
    end
  end


  def get_coords(message)
    cursor = @board.cursor
    loop do
      system "clear"
      @board.display
      puts "It's #{@color}'s turn."
      puts message
      input = $stdin.getch
      case input
      when "\e" || "x"
        raise SaveAndExit.new
      when " "
        return cursor.dup
      when 'w'
        cursor[0] -= 1 unless cursor[0] == 0
      when 's'
        cursor[0] += 1 unless cursor[0] == 7
      when 'a'
        cursor[1] -= 1 unless cursor[1] == 0
      when 'd'
        cursor[1] += 1 unless cursor[0] == 7
      when "\r"
        return [cursor.dup, :stop]
      end
    end
  end

end
