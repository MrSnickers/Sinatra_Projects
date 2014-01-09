###CLASS MOUSE

class Mouse


attr_reader :path_marker, :board, :face
attr_accessor :x_position, :y_position, :backwards_path, :personal_marker, :squares_visited

  def initialize(board)
    @backwards_path = {}
    @squares_visited = []
    @personal_marker
    @face = "8"
    @x_position
    @y_position
    @board = board 
  end

  def set_left_start_point
    @x_position = 0
    @y_position = find_left_entry
  end

  def set_right_start_point
    @x_position = 0
    @y_position = find_right_entry
  end

  def find_left_entry
    board.maze[0].each_with_index do |value, index|
      return index if value == @board.open_value
    end
  end

  def find_right_entry
    maze[maze.length - 1].each_with_index do |value, index|
      return index if value == open_value
    end
  end

  def validate(x_coordinate, y_coordinate)
    [x_coordinate, y_coordinate] if x_coordinate >= 0 && x_coordinate < board.maze.length && y_coordinate >= 0 && y_coordinate < board.maze[0].length
  end

  def valid_positions
    valid_options = [
                      validate(x_position+1, y_position),
                      validate(x_position, y_position-1),
                      validate(x_position, y_position+1),
                      validate(x_position-1, y_position)
                   ]
      puts "it's valid!"
    valid_options.compact.shuffle

  end

  def find_open_positions
    open_positions = []
    valid_positions.each do |coordinate_array|
      open_positions << coordinate_array if board.maze[coordinate_array[0]][coordinate_array[1]] != board.wall_value
    end
    puts "I'm at #{x_position}, #{y_position}."
    puts "open positions are #{open_positions.inspect}"
    open_positions
  end

  def fresh_squares
   fs=find_open_positions.select{|position| !squares_visited.include?(position)}
   puts "fresh squares are #{fs}"
   fs
  end

  def move_to_first_open_position
    new_square = fresh_squares[0]
    if new_square
      new_x = new_square[0]
      new_y = new_square[1]
      squares_visited << new_square
      backwards_path[[x_position, y_position]] = new_square
      place_marker
      @x_position = new_x
      @y_position = new_y
      show_face
    else
      backtrack
      puts "backing up!"
    end
  end

  def backtrack
    puts self.inspect
    place_marker
    parent_square = backwards_path.key([x_position, y_position])
    @x_position = parent_square[0]
    @y_position = parent_square[1]
    show_face
  end

  def place_marker
    board.maze[x_position][y_position] = personal_marker
  end

  def show_face
    board.maze[x_position][y_position] = face
  end

end







