###CLASS BOARD


class Board

### Assumes wall_value does not equal "o" or "x." That there is only one open space for an entrance and an exit. That entrance and exit are on left and right hand sides.

attr_reader :maze, :mice, :open_value, :wall_value, :solved_by

  def initialize
    @maze = []
    @open_value
    @wall_value
    @mice = []
    @solved_by = false
  end

  def create_maze(file)
    open_file = File.open(file)
    array = open_file.readlines
    array.each_with_index do |string, index|
      array[index] = string.chop!.split("")
      self.maze << array[index]
    end
    @maze = maze.transpose
  end

  def set_open(open_value, wall_value)
    @open_value = open_value
    @wall_value = wall_value
  end

  def make_mice(number)
    counter = 1
    number.times do
      mouse = Mouse.new(self)
      mouse.personal_marker = counter
      mouse.set_left_start_point
      mice << mouse
      counter +=1
    end
  end

  def turn
    mice.each do |mouse|
      mouse.move_to_first_open_position
      @solved_by = mouse if mouse.x_position == @maze.length-1
    end
    
  end


end





