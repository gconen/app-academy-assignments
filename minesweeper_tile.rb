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

  def initialize(x,y, board)
    @revealed = false
    @bomb = false
    @contents = "*"
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

  def reveal
    result = neighbor_bomb_count
    @contents = result
    @revealed = true
    if result == 0
      neighbors.each do |neighbor|
        unless neighbor.revealed || neighbor.flagged
          neighbor.reveal
        end
      end
    end
  end

  def to_s
    if @revealed
      return 'B' if @bomb
      return '_' if @contents == 0
      return @contents.to_s
    else
      return 'F' if @flagged
      return '*'
    end
  end

  def set_flag
    @flagged = true
  end
end
