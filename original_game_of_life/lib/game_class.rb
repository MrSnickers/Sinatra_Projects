### BOARD CLASS 2.0

class Game

attr_reader  :width, :height, :board

  def initialize(w,h)
  @width = w
  @height = h
  @board = Array.new(width) {Array.new(height)}
  @pause = false

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
    end
  end

  def create_blinker
    board[10, 9].alive = true
    board[10, 10].alive = true
    board[10, 11].alive = true
  end

  def create_pulsar
    board[10, 7].alive = true
    board[9, 8].alive = true
    board[11, 8].alive = true
    board[9, 9].alive = true
    board[11, 9].alive = true
    board[10, 10].alive = true
    board[9, 11].alive = true
    board[11, 11].alive = true
    board[9, 12].alive = true
    board[11, 12].alive = true
    board[10, 13].alive = true
  end

  def scan_all_cells
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
    while width_counter < width do
      while height_counter < height do
        if @board[width_counter][height_counter].alive == false
            print "   ".color(0, 0, 0)
        else
            print " O ".color(255, 255, 255)
        end
        height_counter += 1
      end
      height_counter = 0
      width_counter += 1
      print "\n"
    end
  end


end