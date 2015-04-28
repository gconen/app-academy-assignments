class Board
  NUM_BOMBS = 1

  def initialize
    @board = Array.new(9) { Array.new(9) }
    populate
  end

  def over?
    count = 0
    @board.each do |row|
      row.each do |tile|
        count += 1 unless tile.revealed
        if tile.bomb && tile.revealed
          lose
          return true
        end
      end
    end

    if count == NUM_BOMBS
      puts "You Win!"
      return true
    end

    false
  end

  def display
    @board.each do |row|
      row.each do |tile|
        print tile
      end
      print "\n"
    end

    nil
  end

  def flag_bomb(*pos)
    if self[*pos].revealed
      puts "That is already revealed. Are you sure?"
      return if gets.chomp == 'n'
    end

    self[*pos].set_flag
  end

  def lose
    puts "You lose"
    @board.each { |row| row.each { |tile| tile.reveal } }
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

  def reveal(*pos)
    if self[*pos].flagged
      puts "That spot has a flag. Are you sure?"
      return if gets.chomp == 'n'
    end

    self[*pos].reveal
  end

  def [] (*pos)
    @board[pos[0]][pos[1]]
  end
end
