require "byebug"
class MazeSolver

  def initialize
    open_maze(ARGV[0])
    find_start
    @path = []
  end

  def open_maze(filename)
    @maze = File.readlines(filename).map do |line|
      line.chars
    end
  end

  def find_start
    @maze.each_with_index do |element, index|
      if element.include?("S")
        @location = [index, element.index('S')]
      end
    end
  end

  def step
    new_location = determine_new_location
    if new_location.nil?
      backup
      return
    end
    @path << @location
    @location = new_location
    if  @maze[@location[0]][@location[1]] == 'E'
      win
    else
      @maze[@location[0]][@location[1]] = 'V'
    end
  end

  def win
    @win = true
    p @path
    output_maze
  end

  def output_maze
    output = @maze.map { |row| row.join("")}
    puts output.join("")
  end

  def backup
    @maze[@location[0]][@location[1]] = 'B'
    @location = @path.pop
  end

  def determine_new_location
    if clear?([ @location[0] -1, @location[1]  ])
      return [ @location[0] -1, @location[1] ]
    elsif clear?([ @location[0], @location[1]+1 ])
      return [ @location[0], @location[1]+1 ]
    elsif clear?([ @location[0] + 1 , @location[1] ])
      return [ @location[0] + 1, @location[1] ]
    elsif clear?([ @location[0], @location[1]-1])
      return [ @location[0], @location[1]-1]
    else
      return nil
    end
  end

  def clear?(location)
    #debugger
    if @maze[location[0]][location[1]] == ' ' || @maze[location[0]][location[1]] == 'E'
      return true
    end
    false
  end


  def find_path
    @win = false
    until @win
      step
    end
  end


end

maze = MazeSolver.new
maze.find_path
