### BOARD CLASS 2.0

class Game

attr_reader  :width, :height, :board, :tick_count
attr_accessor :pause,:alive_cell_count, :alive_cell_history, :cell_age_histogram

  def initialize(w,h)
  @width = w
  @height = h
  @board = Array.new(width) {Array.new(height)}
  @tick_count = 0
  @pause = false
  @alive_cell_count = 0
  @alive_cell_history = []
  @cell_age_histogram = []

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

  def sort_histogram
    sorted_histogram = []
    cell_age_histogram.each do |element|
      if sorted_histogram[element].nil?
        sorted_histogram[element] = 0
      else
      sorted_histogram[element] +=1
      end
    end
    sorted_histogram
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
    board[10, 9].alive = true
    board[10, 10].alive = true
    board[10, 11].alive = true
  end

  def create_pulsar
    board[10][7].alive = true
    board[9][8].alive = true
    board[11][8].alive = true
    board[9][9].alive = true
    board[11][9].alive = true
    board[10][10].alive = true
    board[9][11].alive = true
    board[11][11].alive = true
    board[9][12].alive = true
    board[11][12].alive = true
    board[10][13].alive = true
  end

  def create_glider_gun
    #game = Game.new(28, 40)

    board[5][1].alive = true
    board[5][2].alive = true
    board[6][1].alive = true
    board[6][2].alive = true

    board[5][1].age = 1
    board[5][2].age = 1
    board[6][1].age = 1
    board[6][2].age = 1

  # Right Block
    board[3][35].alive = true
    board[3][36].alive = true
    board[4][35].alive = true
    board[4][36].alive = true

    board[3][35].age = 1
    board[3][36].age = 1
    board[4][35].age = 1
    board[4][36].age = 1

  # Columns 11-18
    board[5][11].alive = true # 1
    board[6][11].alive = true # 2
    board[7][11].alive = true # 3
    board[4][12].alive = true # 4
    board[8][12].alive = true # 5
    board[3][13].alive = true # 6
    board[9][13].alive = true # 7
    board[3][14].alive = true # 8
    board[9][14].alive = true # 9
    board[6][15].alive = true # 10
    board[4][16].alive = true # 11
    board[8][16].alive = true # 12
    board[5][17].alive = true # 13
    board[6][17].alive = true # 14
    board[7][17].alive = true # 15
    board[6][18].alive = true # 16

    board[5][11].age = 1 # 1
    board[6][11].age = 1 # 2
    board[7][11].age = 1 # 3
    board[4][12].age = 1 # 4
    board[8][12].age = 1 # 5
    board[3][13].age = 1 # 6
    board[9][13].age = 1 # 7
    board[3][14].age = 1 # 8
    board[9][14].age = 1 # 9
    board[6][15].age = 1 # 10
    board[4][16].age = 1 # 11
    board[8][16].age = 1 # 12
    board[5][17].age = 1 # 13
    board[6][17].age = 1 # 14
    board[7][17].age = 1 # 15
    board[6][18].age = 1 # 16

    # Columns 21-25
    board[3][21].alive = true # 1
    board[4][21].alive = true # 2
    board[5][21].alive = true # 3
    board[3][22].alive = true # 4
    board[4][22].alive = true # 5
    board[5][22].alive = true # 6
    board[2][23].alive = true # 7
    board[6][23].alive = true # 8
    board[1][25].alive = true # 9
    board[2][25].alive = true # 10
    board[6][25].alive = true # 11
    board[7][25].alive = true # 12

    board[3][21].age = 1 # 1
    board[4][21].age = 1 # 2
    board[5][21].age = 1 # 3
    board[3][22].age = 1 # 4

    board[4][22].age = 1 # 5
    board[5][22].age = 1 # 6
    board[2][23].age = 1 # 7
    board[6][23].age = 1 # 8
    board[1][25].age = 1 # 9
    board[2][25].age = 1 # 10
    board[6][25].age = 1 # 11
    board[7][25].age = 1 # 12
  end

  end