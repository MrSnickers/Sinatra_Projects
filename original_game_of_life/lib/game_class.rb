### BOARD CLASS 2.0

class Game

attr_reader  :width, :height, :board, :tick_count
attr_accessor :pause,:alive_cell_count, :alive_cell_history

  def initialize(w,h)
  @width = w
  @height = h
  @board = Array.new(width) {Array.new(height)}
  @tick_count = 0
  @pause = false
  @alive_cell_count = 0
  @alive_cell_history = []

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
      self.alive_cell_count += 1
    end
    self.alive_cell_history << self.alive_cell_count
    self.alive_cell_count = 0
  end

  def create_blinker
    board[10][9].alive = true
    board[10][10].alive = true
    board[10][11].alive = true
  end

  def create_pulsar
    board[7][7].alive = true
    board[6][8].alive = true
    board[8][8].alive = true
    board[6][9].alive = true
    board[8][9].alive = true
    board[7][10].alive = true
    board[6][11].alive = true
    board[8][11].alive = true
    board[6][12].alive = true
    board[8][12].alive = true
    board[7][13].alive = true
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

  def stable_state_check
     @pause = true if @alive_cell_history[-10..-1].uniq.length == 1
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
    @tick_count += 1
    self.alive_cell_history << self.alive_cell_count
    self.alive_cell_count = 0
    self.stable_state_check if @tick_count > 10
  end


end