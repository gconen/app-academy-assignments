class Game
  NUM_BOMBS = 10
  # attr_reader :board #testing only!

  def initialize
    @board = Array.new(9) { Array.new(9) }
    populate
  end

  def check_win
    count = 0
    @board.each do |row|
      row.each do |tile|
        count += 1 if tile.display == '*' || tile.display == 'F'
      end
    end

    if count == NUM_BOMBS
      @won = true
      puts "You Win!"
    end
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
    if self[*pos].display =~ /[_1-9]/
      puts "That is already revealed. Are you sure?"
      return if gets.chomp == 'n'
    end

    @board[pos[0]][pos[1]].set_flag
  end

  def lose
    puts "You lose"
    @board.each { |row| row.each { |tile| tile.reveal } }
    @lost = true
  end

  def over?
    @lost || @won
  end

  def play
    until over?
      display
      turn
      check_win
    end
    display
  end

  def populate
    populate_blank
    populate_bombs
  end

  def populate_bombs
    bomb_locs = []
    until bomb_locs.length == NUM_BOMBS
      pos = [rand(9), rand(9)]
      bomb_locs << pos unless bomb_locs.include?(pos)
    end

    bomb_locs.each do |pos|
      self[*pos].place_bomb
    end
  end

  def populate_blank
    @board.each_index do |x|
      @board[x].each_index { |y| @board[x][y] = Tile.new(x,y, @board) }
    end
  end

  def prompt_input
    puts "Give us a coordinate"
    input = gets.chomp.split("")
    input.map! {|el| Integer(el)}
  end

  def reveal(*pos)
    if self[*pos].display == 'F'
      puts "That spot has a flag. Are you sure?"
      return if gets.chomp == 'n'
    end

    self[*pos].reveal
    lose if self[*pos].bomb
  end

  def [] (*pos)
    @board[pos[0]][pos[1]]
  end

  def turn
    input = prompt_input
    puts "Place a (f)lag or (r)eveal a square"
    if gets.chomp.downcase == 'f'
      flag_bomb(*input)
    else
      reveal(*input)
    end
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
