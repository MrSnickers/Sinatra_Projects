require "./lib/board_class.rb"

board = Board.new
board.open_maze("./data/dog_maze.rb")

puts board.maze[0]

