### BOARD CLASS


class Game

attr_reader :board, :width, :height

  def initialize(w, h)

  @width = w
  @height = h
  @board = Array.new(width) {Array.new(height)}

  width_counter = 0
  height_counter = 0

    while width_counter < width do
      while height_counter < height do
        board[width_counter][height_counter] = Cell.new(width_counter, height_counter, self)
        height_counter += 1
      end
      height_counter = 0
      width_counter +=1
    end
end

  def randomize_live_cells(cell_count)
    cell_count.times do
      current_cell = board[rand(0...width)][rand(0...height)]
      current_cell.alive = true
      current_cell.age = 1
    end
  end

  def call_all_cells
    width_counter = 0
    height_counter = 0

    while width_counter < width do
      while height_counter < height do
        board[width_counter][height_counter].decide
        height_counter += 1
      end
      height_counter = 0
      width_counter +=1
    end
  end

  def tick
    width_counter = 0
    height_counter = 0

    while width_counter < width do
      while height_counter < height do
        board[width_counter][height_counter].alive = board[width_counter][height_counter].stay_alive
        height_counter += 1
      end
      height_counter = 0
      width_counter +=1
    end
  end

  def print_board
    width_counter = 0
    height_counter = 0
    red_color = 255
    green_color = 255
    blue_color = 0
      while width_counter < width do
        while height_counter < height do
          if @board[width_counter][height_counter].age == 0
              print "   ".color(0, 0, 0)
          elsif
              if board[width_counter][height_counter].age == 1
                    red_color = 255
                elsif @board[width_counter][height_counter].age < 5
                    red_color = 255 - @board[width_counter][height_counter].age * 51
                else
                  red_color = 0
                end
              if @board[width_counter][height_counter].age <= 255
                if board[width_counter][height_counter].age == 1
                  blue_color = 255
                elsif @board[width_counter][height_counter].age < 5
                  blue_color = 255 -(@board[width_counter][height_counter].age * 51)
                else
                  blue_color = 0
                end

                if board[width_counter][height_counter].age == 1
                    green_color = 0
                elsif @board[width_counter][height_counter].age < 5
                    green_color = @board[width_counter][height_counter].age * 51
                else
                  green_color = 255
                end
            print " O ".color(red_color, green_color,  blue_color)
            else
              print " O ".color(255, 0, 255)
            end
          end
          height_counter += 1
        end
        height_counter = 0
        width_counter += 1
        print "\n"
      end

  end


end