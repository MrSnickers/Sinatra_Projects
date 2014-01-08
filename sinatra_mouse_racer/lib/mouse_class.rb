###CLASS MOUSE

class Mouse

### Assumes wall_value does not equal "o" or "x." That there is only one open space for an entrance and an exit. That entrance and exit are on left and right hand sides.

attr_reader :path_marker, :board
attr_accessor :x_position, :y_position, :visited_path, :personal_marker

  def initialize(board)
    @visited_path = []
    @backtrack_counter = -2
    @personal_marker
    @x_position
    @y_position
    @board = board 
  end



#### moves mouse to first open position on the left hand side
  def set_left_start_point
    @x_position = 0
    @y_position = find_left_entry
  end

#### moves mouse to first open position on the right hand side
  def set_right_start_point
    @x_position = 0
    @y_position = find_right_entry
  end

#####returns the y_coordinate of the first open position on the left hand side of a maze as a single integer
  def find_left_entry
    board.maze[0].each_with_index do |value, index|
      return index if value == @board.open_value
    end
  end

#####returns the y_coordinate of the first open position on the right hand side of a maze as a single integer
  def find_right_entry
    maze[maze.length - 1].each_with_index do |value, index|
      return index if value == open_value
    end
  end

###checks x and y coordinate pairs to ensure they do not run off the board.  Returns pairs in form [x_coordinate, y_coordinate]
  def validate(x_coordinate, y_coordinate)
    if x_coordinate >= 0 && x_coordinate < board.maze.length && y_coordinate >= 0 && y_coordinate < board.maze[0].length
      [x_coordinate, y_coordinate]
    else
      nil
    end
  end

#####returns array of valid index pairs in the form of [x_coordinate, y_coordinate].  Currently preventing diagonal movement.
  def valid_positions
    valid_options = [
                     validate(x_position, y_position+1),
                     validate(x_position-1, y_position),
                     validate(x_position+1, y_position),
                     validate(x_position, y_position-1),
                   ]

    valid_options.compact
  end

###searches along the unshuffled valid position array is essentially a clockwise search.######this might be useful for keeping wall on right hand side

  def find_open_positions
    open_positions = []
    valid_positions.each do |coordinate_array|
      open_positions << coordinate_array if board.maze[coordinate_array[0]][coordinate_array[1]] == board.open_value
    end
    open_positions
  end

  def avoid_path
    find_open_positions.select{|position| !visited_path.include?(position)}
  end

  def move_to_first_open_position
    if avoid_path[0]
      visited_path << [x_position, y_position]
      x_coordinate = find_open_positions[0][0]
      y_coordinate = find_open_positions[0][1]
    else
      backtrack
    end
  end

  def backtrack
      x_position = visited_path[-2][0]
      y_position = visited_path[-2][1]
  end

end







