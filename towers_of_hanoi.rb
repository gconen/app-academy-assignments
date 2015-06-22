class TowerOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def take_a_turn
    p @towers
    puts "What tower do you want to move from? (1, 2, or 3)"
    start = get_tower_index
    puts "What tower do you want to move to?"
    finish = get_tower_index
    move(start, finish)
  end

  def get_tower_index
    loop do
      tower = gets.chomp
      if tower =~ /[1-3]/
        return Integer(tower)
      end
      puts "Invalid input"
    end
  end

  def move(start, finish)
    start -= 1; finish -= 1
    if @towers[start].empty?
      puts "There's no disks in that tower."
      return
    end
    if @towers[finish].empty? || @towers[finish].last > @towers[start].last
      @towers[finish] << @towers[start].pop
    else
      puts "Invalid move."
    end
    return @towers
  end

  def play
    until @towers.last == [3,2,1]
      take_a_turn
    end
    puts "You Won!"
  end
end

game = TowerOfHanoi.new
game.play
