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
    return nil if self[pos]

    self[pos] = Piece.new(pos, color, self)
  end

  def pieces
    @grid.flatten.compact
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
end
