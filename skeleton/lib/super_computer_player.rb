require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    moves = TicTacToeNode.new(game.board, mark).children
    moves.each do |move|
      return move.prev_move_pos  if move.winning_node?(mark)
    end

    moves.reject! do |move|
      move.losing_node?(mark)
    end
    return moves.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
