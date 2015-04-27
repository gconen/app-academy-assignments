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

  attr_reader :display, :bomb

  def initialize(x,y, board)
    @bomb = false
    @display = "*"
    @position = [x,y]
    @board = board
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
    result = @bomb ? 'B' : neighbor_bomb_count.to_s
    @display = result
    if result == '0'
      @display = '_'
      neighbors.each { |neighbor| neighbor.reveal if neighbor.display == "*" }
    end
  end

  def set_flag
    @display = 'F'
  end
end
