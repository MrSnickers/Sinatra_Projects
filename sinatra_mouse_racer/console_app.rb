    require "./lib/board_class"
    require "./lib/mouse_class"
    require 'debugger'


    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ", "#")
    board.make_mice(1)

    10.times do
      debugger
      board.turn
      
    end