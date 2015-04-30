require_relative "array_patch.rb"

class Piece
  attr_reader :board, :color, :king
  attr_accessor :pos

  def initialize(pos, color, board, king = false)
    @king = king
    @color = color
    @pos = pos
    @board = board
  end

  def display
    display = color == :red ? 'r' : 'w'
    display.upcase! if @king
    display
  end

  def dup_with_board(board)
    Piece.new(@pos, @color, board, @king)
  end

  def inspect
     {color: @color, position: @pos, board: @board.class}.inspect
  end

  def perform_slide(goal)
    return false unless @board.in_bounds?(goal)
    return false unless slide_moves.include?(goal)
    return false if board[goal]

    set_pos(goal)
    check_promote
    true
  end

  def perform_jump(goal)
    return false unless @board.in_bounds?(goal)
    direction = move_directions.find do |dir|
      goal == @pos.v_add( dir.v_mult(2) )
    end
    #not a possible move
    return false if direction.nil?
    #no piece to jump
    return false unless @board.opponent_at?(@pos.v_add(direction), @color)
    #final square not open
    return false if @board[goal]


    @board.capture_at(pos.v_add(direction))
    set_pos(goal)
    check_promote
    true
  end

  def valid_moves?(move_sequence)
    new_board = @board.deep_dup
    new_self = new_board[@pos]
    begin
      new_self.perform_moves!(move_sequence)
    rescue IllegalMoveError #Note to self: not all errors
      false
    else
      true
    end
  end

  def perform_moves(move_sequence)
    unless valid_moves?(move_sequence)
      raise IllegalMoveError.new "Attempted Illegal Sequence"
    end

    perform_moves!(move_sequence)
  end

  #private
  def check_promote
    promote_row = @color == :red ? 7 : 0
    @king = true if @pos[0] == promote_row
  end

  def perform_moves!(move_sequence)
    raise IllegalMoveError.new "Empty Sequence" if move_sequence.length < 1
    if move_sequence.length == 1
      performed = perform_slide(move_sequence[0])
      return if performed
    end
    #if it's longer or slide fails
    move_sequence.each do |move|
      performed = perform_jump(move)
      raise IllegalMoveError.new "Invalid Sequence Performed" unless performed
    end
    #todo: stop when kinged
    #todo: check further jumps in sequence (all jumps are mandatory)
    nil
  end

  def set_pos(goal)
    @board[@pos] = nil
    @board[goal] = self
    @pos = goal
  end

  def move_directions
    return [[1, 1], [-1, 1], [-1, -1], [1, -1]] if @king
    @color == :red ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end

  def slide_moves
    slide_moves = move_directions.map { |direction| @pos.v_add(direction)}
  end
end
