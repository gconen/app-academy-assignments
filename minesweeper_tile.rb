class Tile
  NEIGHBORS = [
    [-1,-1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0,  1],
    [1, -1],
    [1,  0],
    [1,  1]
  ]

  attr_reader :bomb, :revealed, :flagged

  # NR: You can do without @contents.
  def initialize(x,y, board)
    @revealed = false
    @bomb = false
    @position = [x,y]
    @board = board
    @flagged = false
  end

  def neighbors
    neighbors = NEIGHBORS.map do |coords|
      [coords[0] + @position[0], coords[1] + @position[1]]
    end
    neighbors.select! { |coords| coords.all?{ |coord| coord.between?(0,8)} }
    neighbors.map { |neighbor| @board[neighbor.first][neighbor.last] }
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      count += 1 if neighbor.bomb
    end
    count
  end

  def place_bomb
    @bomb = true
  end

  # I might stop immediately if already revealed.
  def reveal
    return if @revealed
    @revealed = true
    if neighbor_bomb_count == 0
      neighbors.each do |neighbor|
        unless neighbor.flagged
          neighbor.reveal
        end
      end
    end
  end

  def to_s
    if @revealed
      return 'B' if @bomb
      return '_' if neighbor_bomb_count == 0
      return neighbor_bomb_count.to_s
    else
      return 'F' if @flagged
      return '*'
    end
  end

  def set_flag
    @flagged = true
  end
end
