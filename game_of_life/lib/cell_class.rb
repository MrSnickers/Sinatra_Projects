### CELL CLASS


class Cell
  attr_accessor :alive, :stay_alive, :age
  attr_reader :location_x, :location_y, :game

def initialize(x,y, game)
  @location_x = x
  @location_y = y
  @game = game
  @alive = false
  @stay_alive = false
  @age = 0
end

def validate(x_coordinate, y_coordinate)
  if x_coordinate >= 0 && x_coordinate < game.width && y_coordinate >= 0 && y_coordinate < game.height
    game.board[x_coordinate][y_coordinate]
  else
    nil
  end

end

def neighbor_check
    x = @location_x
    y = @location_y
    valid_neighbor_array = [validate(x-1, y+1), validate(x, y+1), validate(x+1, y+1), validate(x-1, y), validate(x+1, y), validate(x-1, y-1), validate(x, y-1), validate(x+1, y-1)]
    valid_neighbor_array.compact.select {|cell| cell.alive == true}.length

end

def decide
  if neighbor_check < 2 || neighbor_check > 3
    @stay_alive = false
    @age = 0
  elsif neighbor_check == 3
    @stay_alive = true
    @age += 1
  elsif neighbor_check == 2 && @alive == true
    @stay_alive = true
    @age +=1
  elsif neighbor_check == 2 && @alive == false
    @stay_alive = false
  end


end


end
