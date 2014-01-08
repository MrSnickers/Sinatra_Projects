###CLASS BOARD

require "rainbow"

class Board

### Assumes wall_value does not equal "o" or "x." That there is only one open space for an entrance and an exit. That entrance and exit are on left and right hand sides.

attr_reader :path_value, :open_values, :mouse_face, :visited_value, :mouse_tile_status, :solved, :mutable_values
attr_accessor :leading_x, :leading_y, :maze

  def initialize
    @maze = []
    @leading_x
    @leading_y
    @open_values = [" ", ":",",",".","=","+","~"]
    @mutable_values = ["/", "$", "?", "J"]
    @path_value = "10"
    @visited_value = "20"
    @mouse_face = "\u1F42D" ## actual mouse is 1F42D heart is \u2764
    @mouse_tile_status
    @solved = false
  end

  def open_maze(file)
    open_file = File.open(file)
    array = open_file.readlines
    array.each_with_index do |string, index|
      array[index] = string.chop!.split("")
      self.maze << array[index]
    end
    @maze = @maze.transpose
  end

  def carve_path
    # set_left_start_point
    # 800.times do
    #   not_passible = true
    #   openspaces = []
    #     valid_positions.each do |coordinate_array|
    #     if not_passible && open_values.include?(maze[coordinate_array[0]][coordinate_array[1]])
    #       openspaces << coordinate_array
    #       not_passible = false
    #     end
    #       if not_passible == false
    #         if openspaces.length == 1
    #           maze[openspaces[0][0]][openspaces[0][1]] = "J"
    #           @leading_x = openspaces[0][0]
    #           @leading_y = openspaces[0][1]
    #       else
    #         openspaces.each do |coordinate_array|
    #           near_wall =[]
    #           near_wall << coordinate_array
    #           near_wall.shuffle


    #         end

    #       end
    #     end
    #     valid_positions.each do |coordinate_array|
    #       if not_passible && mutable_values.include?(maze[coordinate_array[0]][coordinate_array[1]])
    #         maze[coordinate_array[0]][coordinate_array[1]] = "F"
    #         @leading_x = coordinate_array[0]
    #         @leading_y = coordinate_array[1]
    #         not_passible = false
    #       end
    #     end
    #   end
  end



#### moves mouse to first open position on the left hand side
  def set_left_start_point
    @leading_x = 0
    @leading_y = find_left_entry
  end


#####returns the y_coordinate of the first open position on the right hand side of a maze as a single integer
  def find_left_entry
    not_found = true
    if not_found
      maze[0].each_with_index do |value, index|
        if @open_values.include?(value)
          value = "J"
          not_found = false
          puts index
          return index
        end
      end
    end
  if not_found
      maze[0].each_with_index do |value, index|
        if @mutable_values.include?(value)
          value = "J"
          not_found = false
          return index
        end
      end
    end
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
    valid_options = [ validate(leading_x+1, leading_y),
                      validate(leading_x, leading_y+1),
                      validate(leading_x-1, leading_y),
                      validate(leading_x, leading_y-1),
                      
                   ]

    valid_options.compact
  end

    def valid_neighbors
    valid_options = [ validate(coordinate_array[0]+1, coordinate_array[1]+1),
                      validate(coordinate_array[0], coordinate_array[1]+1),
                      validate(coordinate_array[0], coordinate_array[1]-1),
                      validate(coordinate_array[0]-1, coordinate_array[1]),
                      
                   ]

    valid_options.compact
  end

###searches along the unshuffled valid position array is essentially a clockwise search.######this might be useful for keeping wall on right hand side
  def move_to_first_open_position
  #   valid_positions.shuffle.each do |coordinate_array|
  #     if maze[coordinate_array[0]][coordinate_array[1]] == open_value
  #       if @maze[leading_x][leading_y] == open_value
  #           @maze[leading_x][leading_y] = path_value
  #       elsif
  #         @maze[leading_x][leading_y] = visited_value
  #       end
  #       @leading_x = coordinate_array[0]
  #       @leading_y = coordinate_array[1]
  #       return
  #     end
  #   end
  #   valid_positions.each do |coordinate_array|
  #       if maze[coordinate_array[0]][coordinate_array[1]] == path_value
  #     @maze[leading_x][leading_y] = visited_value
  #     @leading_x = coordinate_array[0]
  #     @leading_y = coordinate_array[1]
  #     break
  #     end
  #   end
  end

  def show_mouse
    @mouse_tile_status = self.maze[leading_x][leading_y]
    self.maze[leading_x][leading_y] = mouse_face
  end

  def put_tile_back
    self.maze[leading_x][leading_y] = @mouse_tile_status
  end

end





