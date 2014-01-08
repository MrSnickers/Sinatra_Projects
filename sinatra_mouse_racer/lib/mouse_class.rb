###CLASS MOUSE

class Mouse

### Assumes wall_value does not equal "o" or "x." That there is only one open space for an entrance and an exit. That entrance and exit are on left and right hand sides.

attr_reader :path_marker, :board, :face
attr_accessor :x_position, :y_position, :visited_squares, :personal_marker

  def initialize(board)
    @visited_squares = {}
    @personal_marker
    @face = "8"
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
    [x_coordinate, y_coordinate] if x_coordinate >= 0 && x_coordinate < board.maze.length && y_coordinate >= 0 && y_coordinate < board.maze[0].length
  end

#####returns array of valid index pairs in the form of [x_coordinate, y_coordinate].  Currently preventing diagonal movement.
  def valid_positions
    valid_options = [
                      validate(x_position+1, y_position),
                      validate(x_position, y_position-1),
                      validate(x_position, y_position+1),
                      validate(x_position-1, y_position)
                   ]

    valid_options.compact
  end

  def find_open_positions
    open_positions = []
    valid_positions.each do |coordinate_array|
      open_positions << coordinate_array if board.maze[coordinate_array[0]][coordinate_array[1]] != board.wall_value
    end
    open_positions
  end

  def fresh_squares
   find_open_positions.select{|position| !visited_squares.has_value?(position)}
  end

  def move_to_first_open_position
    debugger
    if fresh_squares[0]
      new_x = find_open_positions[0][0]
      new_y = find_open_positions[0][1]
      visited_squares[[x_position, y_position]] = [new_x, new_y]
      board.maze[x_position][y_position] = personal_marker
      @x_position = find_open_positions[0][0]
      @y_position = find_open_positions[0][1]
      board.maze[@x_position][@y_position] = face
    else
      backtrack
    end
  end

  def backtrack
    parent_square = visited_squares.key([x_position, y_position])
    @x_position = parent_square[0]
    @y_position = parent_square[1]
  end

end







