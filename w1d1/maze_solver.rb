class MazeSolver

  def initialize
    open_maze(ARGV[0])
    p @maze
  end

  def open_maze(filename)
    @maze = File.readlines(filename).map do |line|
      line.chars
    end
  end

end
