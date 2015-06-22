require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @children ||= @board.open_spots.map do |pos|
      generate_child_node(pos)
    end
  end

  def generate_child_node(pos)
    next_move_board = @board.dup
    next_move_board[pos] = @next_mover_mark
    TicTacToeNode.new(
      next_move_board,
      switch(@next_mover_mark),
      pos
    )
  end

  def losing_node?(evaluator)
    winner = @board.winner
    return winner != evaluator if winner
    current_children = children
    return false if current_children.empty?

    if evaluator == @next_mover_mark
      return current_children.all? { |child| child.losing_node?(evaluator) }
    else
      return current_children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def switch(mark)
    return mark == :x ? :o : :x
  end

  def winning_node?(evaluator)
    winner = @board.winner
    return winner == evaluator if winner
    current_children = children
    return false if current_children.empty?

    if evaluator == @next_mover_mark
      return current_children.any? { |child| child.winning_node?(evaluator) }
    else
      return current_children.all? { |child| child.winning_node?(evaluator) }
    end

  end

end
