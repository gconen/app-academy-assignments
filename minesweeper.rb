class Game
  BOMBS = 10
  attr_reader :board #testing only!

  def initialize
    @board = Array.new(9) { Array.new(9) }
    populate
  end

  def play
    until over?
      display
      turn
    end
  end

  def prompt_input
    puts "Give us a coordinate"
    input = gets.chomp.split("")
    input.map! {|el| Integer(el)}
  end

  def turn
    reveal(*prompt_input)
  end

  def over?
    @lost || @won
  end

  def lose
    puts "You lose"
    @board.each do |row|
      row.each do |tile|
        tile.reveal
      end
    end
    display
    @lost = true
  end

  def display
    @board.each do |row|
      row.each do |tile|
        print tile.display
      end
      print "\n"
    end
    nil
  end


  def flag_bomb(*pos)
    @board[pos[0]][pos[1]].set_flag
  end

  def populate
    populate_blank
    populate_bombs
  end

  def populate_bombs
    bomb_locs = []
    until bomb_locs.length == 10
      pos = [rand(9), rand(9)]
      bomb_locs << pos unless bomb_locs.include?(pos)
    end

    bomb_locs.each do |(x,y)|
      @board[x][y].place_bomb
    end
  end

  def populate_blank
    @board.each_index do |x|
      @board.each_index do |y|
        @board[x][y] = Tile.new(x,y, @board)
      end
    end
  end

  def reveal(*pos)
    @board[pos[0]][pos[1]].reveal
    lose if @board[pos[0]][pos[1]].bomb
  end
end



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

  attr_reader :display, :bomb, :position, :flag

  def initialize(x,y, board)
    @bomb = false
    @display = "*"
    @position = [x,y]
    @board = board
    @flag = false
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

  def reveal
    result = @bomb ? 'B' : neighbor_bomb_count.to_s
    @display = result
    # if result == '0'
    #   neighbors.each { |neighbor| neighbor.reveal unless neighbor.flag?}
    # end
  end

  def place_bomb
    @bomb = true
  end

  def set_flag
    @flag = true
    @display = 'F'
  end

  def flag?
    return @flag
  end


end
