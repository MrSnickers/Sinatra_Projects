### CELL CLASS 2.0

class Cell
  attr_reader :x_coordinate, :y_coordinate, :neighbors, :game, :age
  attr_accessor :alive, :stay_alive

  def initialize(x,y, game)
    @x_coordinate = x
    @y_coordinate = y
    @game = game
    @neighbors = []
    @alive = false
    @stay_alive = false
    @age = 0
  end

  def validate(x, y)
    if x >= 0 && x < game.width && y >= 0 && y < game.height
      game.board[x][y]
    else
      nil
    end
  end


  def create_neighbor_array
    x = @x_coordinate
    y = @y_coordinate
    @neighbors = [validate(x-1, y+1),
                  validate(x, y+1),
                  validate(x+1, y+1),
                  validate(x-1, y),
                  validate(x+1, y),
                  validate(x-1, y-1),
                  validate(x, y-1),
                  validate(x+1, y-1)].compact
  end

  def live_neighbor_array
    create_neighbor_array if @neighbors == []
    @neighbors.select {|cell| cell.alive == true}
  end

  def live_neighbor_count
    live_neighbor_array.length
  end

  def decide
    if live_neighbor_count < 2 || live_neighbor_count > 3
      @stay_alive = false
      @age = 0
    elsif live_neighbor_count == 3 && @alive == true
      @stay_alive = true
      @age += 1
      game.alive_cell_count += 1
    elsif live_neighbor_count == 3 && @alive == false
      @stay_alive = true
      @age +=1
      game.alive_cell_count += 1
    elsif live_neighbor_count == 2 && @alive == true
      @stay_alive = true
      @age += 1
      game.alive_cell_count += 1
    elsif live_neighbor_count == 2 && @alive == false
      @stay_alive = false
    end
  end

  def red
    if age == 0
      0
    else
      ((125*Math.exp((1-age)*0.1))+125).to_i
    end
  end

  def green
    case age
      when 0
        0
      when 1
        255
      else
        (255-(250*Math.exp((1-age)*0.4))).to_i
      end
  end

  def blue
    if age == 0
      0
    else
      ((170*Math.exp((1-age)*0.1))+35).to_i
    end
  end


end
