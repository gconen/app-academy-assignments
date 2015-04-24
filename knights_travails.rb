require "./00_tree_node.rb"

class KnightPathFinder
  attr_reader :visited_positions

  TRANSPOSES = [
    [1,   2],
    [2,   1],
    [2,  -1],
    [1,  -2],
    [-1, -2],
    [-2, -1],
    [-2,  1],
    [-1,  2],
  ]

  def self.valid_moves(*pos)
    x, y = pos
    moves = TRANSPOSES.map do |transpose|
      [transpose[0] + x, transpose[1] + y]
    end
    moves.select do |move|
      move.all? {|coord| coord >= 0 && coord < 8}
    end
  end

  def initialize(*start)
    @x, @y = start
    @visited_positions = [start]
  end

  def build_move_tree
    @root_node = PolyTreeNode.new([@x, @y])
    queue = [@root_node]
    until queue.empty?
      current = queue.shift
      new_move_positions(*current.value).each do |position|
        queue << PolyTreeNode.new(position, current)
        @visited_positions << position
      end
    end
  end

  def new_move_positions(x,y)
    KnightPathFinder.valid_moves(x, y).reject do |position|
      @visited_positions.include?(position)
    end
  end

  def
end

a = KnightPathFinder.new(0, 0)
a.build_move_tree

p a.visited_positions.length
