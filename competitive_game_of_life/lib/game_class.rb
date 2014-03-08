### BOARD CLASS 2.0

class Game

attr_reader :width, :height
attr_accessor :board, :tick_count, :pause,:alive_cell_count, :alive_cell_history

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
      width_counter += 1
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
      width_counter += 1
    end
  end

  def stable_state_check
     @pause = true if @alive_cell_history[-10..-1].uniq.length == 1
  end

  def tick
    width_counter = 0
    height_counter = 0

    while width_counter < @width do
      while height_counter < @height do
        board[width_counter][height_counter].convert_stay_alive
        board[width_counter][height_counter].convert_ownership
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

  def create_cell(x, y, owner)
    board[x][y].alive = true
    board[x][y].current_ownership = owner
    self.alive_cell_count += 1
  end

  def record_live_cells
    self.alive_cell_history << self.alive_cell_count
    self.alive_cell_count = 0
  end

  def randomize_live_cells(cell_count, owner)
    cell_count.times do
      create_cell(rand(0...width), rand(0...height), owner)
    end
    record_live_cells
  end

  def make_formation(cell_locations, owner)
    cell_locations.each do |coordinates|
      create_cell(coordinates[0], coordinates[1], owner)
    end
    record_live_cells
  end

  def create_blinker(owner)
    make_formation([[10, 9],[10, 10],[10, 11]], owner)
  end

  def create_pulsar(owner)
    make_formation([[11,17],[10,18],[12,18],
        [10,19],[12,19],[11,20],[10,21],
        [12,21],[10,22],[12,22],[11,23]], owner)
  end

  def create_glider_gun
  #Left Block
    make_formation([[5,1],[5,2],[6,1],[6,2]], owner)

  # Right Block
    make_formation([[3,35],[3,36],[4,35],[4,36]], owner)

  # Columns 11-18
    make_formation([[5,11],[6,11],[7,11],[4,12],[8,12],[3,13],[9,13],[3,14],[9,14],[6,15],[4,16],[8,16],[5,17],[6,17],[7,17],[6,18]], owner)

  # Columns 21-25
    make_formation([[3,21],[4,21],[5,21],[3,22],[4,22],[5,22],[2,23],[6,23],[1,25],[2,25],[6,25],[7,25]], owner)
  end

  end