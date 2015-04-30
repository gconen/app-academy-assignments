class Player
  def initialize(color)
    @color = color
  end

  def get_move(board)
    @board = board
    @board.display
    puts "It's #{@color}'s turn"
    piece_pos = get_piece
    move_sequence = get_sequence
    [piece_pos, move_sequence]
  end

  def get_piece
    puts "Which piece to move? (example: 0, 3)"
    input_to_coords(gets.chomp)
  end

  def get_sequence
    input = ""
    sequence = []
    until input.downcase == "end"
      puts "Type a location to move to, or end if you're done"
      input = gets.chomp
      sequence << input_to_coords(input) unless input.downcase == 'end'
    end

    sequence
  end

  def input_to_coords(input)
    raise IllegalMoveError.new "Invalid Coordinates" unless input =~ /\d[,\.] ?\d/
    y, x = input.split(/[,\.] ?/)
    [Integer(y), Integer(x)]
  end
end
