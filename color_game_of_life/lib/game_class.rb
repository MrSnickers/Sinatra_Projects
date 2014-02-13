### BOARD CLASS 2.0

class Game

require 'csv'
attr_reader :width, :height
attr_accessor :board, :tick_count, :pause,:alive_cell_count, :alive_cell_history, :age_at_death_history, :cell_age_census

  def initialize(w,h)
  @width = w
  @height = h
  @board = Array.new(width) {Array.new(height)}
  @tick_count = 0
  @pause = false
  @alive_cell_count = 0
  @alive_cell_history = []
  @age_at_death_history = []
  @cell_age_census = []

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
    @cell_age_census = []

    while width_counter < width do
      while height_counter < height do
        board[width_counter][height_counter].record_age
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

  def reckoning
    @pause = true

    width_counter = 0
    height_counter = 0
    @cell_age_census = []

    while width_counter < @width do
      while height_counter < @height do
        unless board[width_counter][height_counter].age == 0
         board[width_counter][height_counter].record_age
         @age_at_death_history << board[width_counter][height_counter].age
         end 
        height_counter += 1
      end
      height_counter = 0
      width_counter +=1
    end

  end

  def sort_age(data_set)
    sorted_data = []
    data_set.each do |element|
      if sorted_data[element].nil?
        sorted_data[element] = 1
      else
      sorted_data[element] +=1
      end
    end
    sorted_data
  end

  def format_data(data_set)
    formatted = {}
    sort_age(data_set).each_with_index do |frequency, index|
      frequency = 0 if frequency.nil?
      formatted[index] = frequency
    end
    formatted
  end

  def formatted_histogram
    format_data(@age_at_death_history)
  end

  def formatted_census
    format_data(@cell_age_census)
  end

  def export_census
    census = self.formatted_census
    CSV.open("public/data/cells.csv", "wb",
      :write_headers => true,
      :headers => ["age", "frequency"]) do |csv|
      census.to_a.each do |item|
        csv << item
      end
    end
  end

  def export_histogram
    histogram = self.formatted_histogram
    CSV.open("public/data/histogram.csv", "wb",
      :write_headers => true,
      :headers => ["age", "frequency"]) do |csv|
      histogram.to_a.each do |item|
        csv << item
      end
    end
  end

  def create_cell(x, y)
    board[x][y].alive = true
    board[x][y].age = 1
    self.alive_cell_count += 1
  end

  def record_live_cells
    self.alive_cell_history << self.alive_cell_count
    self.alive_cell_count = 0
  end

  def randomize_live_cells(cell_count)
    cell_count.times do
      create_cell(rand(0...width), rand(0...height))
    end
    record_live_cells
  end

  def make_formation(cell_locations)
    cell_locations.each do |coordinates|
      create_cell(coordinates[0], coordinates[1])
    end
    record_live_cells
  end

  def create_blinker
    make_formation([[10, 9],[10, 10],[10, 11]])
  end

  def create_pulsar
    make_formation([[11,17],[10,18],[12,18],
        [10,19],[12,19],[11,20],[10,21],
        [12,21],[10,22],[12,22],[11,23]])
  end

  def create_glider_gun
  #Left Block
    make_formation([[5,1],[5,2],[6,1],[6,2]])

  # Right Block
    make_formation([[3,35],[3,36],[4,35],[4,36]])

  # Columns 11-18
    make_formation([[5,11],[6,11],[7,11],[4,12],[8,12],[3,13],[9,13],[3,14],[9,14],[6,15],[4,16],[8,16],[5,17],[6,17],[7,17],[6,18]])

  # Columns 21-25
    make_formation([[3,21],[4,21],[5,21],[3,22],[4,22],[5,22],[2,23],[6,23],[1,25],[2,25],[6,25],[7,25]])
  end

  end