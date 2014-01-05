###CLASS BOARD

require "rainbow"

class Board

  @@All_boards = []

  ### Assumes wall_value does not equal "o" or "x." That there is only one open space for an entrance and an exit.That entrance and exit are on left and right hand sides.

attr_reader :maze, :path_value, :open_value, :mouse_face, :visited_value, :final_path_length
attr_accessor :leading_x, :leading_y

  def initialize
    @maze = []
    @path_value = "o"
    @visited_value = "x"
    @open_value
    @leading_x
    @leading_y
    @solved = false
    @mouse_face = "\u1F42D" ## actual mouse is 1F42D heart is \u2764
    @final_path_length
  end

  def create_maze(file)
    open_file = File.open(file)
    array = open_file.readlines
    array.each_with_index do |string, index|
      array[index] = string.chop!.split("")
      @maze << array[index]
    end
    @maze = maze.transpose
  end

  def set_open(open_value)
    @open_value = open_value
  end

  def reset_all_boards
     @@All_boards = 0
  end

  def drop_path_marker
    @maze[leading_x][leading_y] = path_value
  end
###mouse moves to coordinate returned from search function
  def move
    @leading_x = coordinate_array[0]
    @leading_y = coordinate_array[1]
  end

###checks x and y coordinate pairs to ensure they do not run off the board.  Returns pairs in form [x_coordinate, y_coordinate]
  def validate(x_coordinate, y_coordinate)
    if x_coordinate >= 0 && x_coordinate < maze.length && y_coordinate >= 0 && y_coordinate < maze[0].length
      [x_coordinate, y_coordinate]
    else
      nil
    end
  end

#####returns array of valid index pairs in the form of [x_coordinate, y_coordinate].  Currently preventing diagonal movement.
  def valid_positions
    valid_options = [
                    #validate(leading_x-1, leading_y+1),
                     validate(leading_x, leading_y+1),
                     #validate(leading_x+1, leading_y+1),
                     validate(leading_x-1, leading_y),
                     validate(leading_x+1, leading_y),
                     #validate(leading_x-1, leading_y-1),
                     validate(leading_x, leading_y-1),
                     #validate(leading_x+1, leading_y-1)
                   ]

    valid_options.compact
  end

###searches along the unshuffled valid position array is essentially a clockwise search.######this might be useful for keeping wall on right hand side
  def move_to_first_open_position
    valid_positions.shuffle.each do |coordinate_array|
      if maze[coordinate_array[0]][coordinate_array[1]] == open_value
        if @maze[leading_x][leading_y] == open_value
            @maze[leading_x][leading_y] = path_value
        elsif
          @maze[leading_x][leading_y] = visited_value
        end
        @leading_x = coordinate_array[0]
        @leading_y = coordinate_array[1]
        return
      end
    end
    valid_positions.shuffle.each do |coordinate_array|
        if maze[coordinate_array[0]][coordinate_array[1]] == path_value
      @maze[leading_x][leading_y] = visited_value
      @leading_x = coordinate_array[0]
      @leading_y = coordinate_array[1]
      break
      end
    end
  end

#####returns the y_coordinate of the first open position on the left hand side of a maze as a single integer
  def find_left_entry
    maze[0].each_with_index do |value, index|
      return index if value == open_value
    end
  end

#####returns the y_coordinate of the first open position on the right hand side of a maze as a single integer
  def find_right_entry
    maze[maze.length - 1].each_with_index do |value, index|
      return index if value == open_value
    end
  end

#### moves mouse to first open position on the left hand side
  def set_left_start_point
    @leading_x = 0
    @leading_y = find_left_entry
  end

#### moves mouse to first open position on the right hand side
  def set_right_start_point
    @leading_x = 0
    @leading_y = find_right_entry
  end


###runs mouse until it reaches the right hand side of the board
  def process_right
    while leading_x < maze.length-1 do
      move_to_first_open_position
      puts "\e[H\e[2J"
      print_board
      sleep 0.1
    end
    @maze[leading_x][leading_y] = mouse_face
    puts "\e[H\e[2J"
    print_board
    sleep 0.1
  end



end
