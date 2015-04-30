require_relative "piece.rb"
require_relative "checkers_errors.rb"

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def capture_at(pos)
    piece = self[pos]
    raise IllegalMoveError.new "No Piece to Capture" if piece.nil?
    self[pos] = nil
    piece.pos = :captured
  end

  def display
    @grid.each do |row|
      p row.map { |el| el.nil? ? nil : el.display }
    end

    nil
  end

  def deep_dup
    new_board = Board.new
    pieces.each do |piece|
      new_piece = piece.dup_with_board(new_board)
      new_board[new_piece.pos] = new_piece
    end

    new_board
  end

  def in_bounds?(pos)
    y, x = pos
    y.between?(0, 7) && x.between?(0, 7)
  end

  def opponent_at?(pos, color)
    self[pos] && self[pos].color != color
  end

  def place_piece(pos, color)
    raise OutOfBoundsError.new unless in_bounds?(pos)
    raise BadPlaceError.new if self[pos]

    self[pos] = Piece.new(pos, color, self)
  end

  def place_starting_pieces
    populate(0, 1, :red)
    populate(1, 0, :red)
    populate(2, 1, :red)
    populate(5, 0, :white)
    populate(6, 1, :white)
    populate(7, 0, :white)
  end

  def won?(color)
    pieces.all? { |piece| piece.color = color }
  end

  def winner
    return :red if won?(:red)
    return :white if won?(:white)
    nil
  end

  def [](pos)
    return nil unless in_bounds?(pos)
    y, x = pos
    @grid[y][x]
  end

  def []=(pos, contents)
    raise OutofBoundsError.new unless in_bounds?(pos)
    y, x = pos
    @grid[y][x] = contents
  end

  private

  def pieces
    @grid.flatten.compact
  end

  def populate(row, start_col, color)
    col = start_col
    until col >=8
      place_piece([row, col], color)

      col += 2
    end

    nil
  end
end
