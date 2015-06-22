require 'byebug'
require 'pry'

class Board
  X = "X"
  O = "O"
  OPEN = "_"

  attr_reader :board
  def initialize
    @board = [
      ['_', '_', '_'],
      ['_', '_', '_'],
      ['_', '_', '_']
    ]
    @won = nil
  end

  def winning_move?(player, *pos)
    return line_winning?(1, 0, player, *pos) ||
            line_winning?(1, 1, player, *pos) ||
            line_winning?(0, 1, player, *pos) ||
            line_winning?(1, -1, player, *pos)
  end

  def line_winning?(dx, dy, player, *pos)
    offset_by_1 = [(pos[0] + 1 * dx) % 3, (pos[1] + 1 * dy) % 3]
    offset_by_2 = [(pos[0] + 2 * dx) % 3, (pos[1] + 2 * dy) % 3]
    at_all?(player, offset_by_1, offset_by_2)
  end

  def mark_at?(mark, *pos)
    return mark == self[*pos]
  end

  def place_mark(mark, *pos)
    self[*pos] = mark
  end

  def at_all?(mark, *positions)
    positions.all? {|pos| mark_at?(mark, *pos)}
  end

  def display
    board.each { |row| p row }
  end

  def [](row, column = nil)
    return board[row][column] if column
    board[row]
  end

  def []=(row, column, value)
    board[row][column] = value
  end

  def make_a_move(player, *pos)
    legal_move?(*pos)
    win(player) if winning_move(player, *pos)
    place_mark(player, *pos)
  end

  def legal_move?(*pos)
    mark_at?('_', *pos)
  end

  def win(player)
    @won = player
  end

end


class Game
  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
  end

  def turn(player_number)
    @players[player_number].get_move
  end
end


binding.pry
