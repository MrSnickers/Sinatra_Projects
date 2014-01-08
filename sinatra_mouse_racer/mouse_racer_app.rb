#### MOUSE RACER APP

require 'bundler'
Bundler.require

require "./lib/board_class"
require "./lib/mouse_class"
# enable 'sessions'


module App
  class Racer< Sinatra::Application

    @@board = Board.new
    @@board.create_maze("./data/maze.rb")
    @@board.set_open(" ", "#")
    @@board.make_mice(1)
    # 4.times do
        # @@board.turn
    # end


    get'/run' do
    @board = @@board
    @@board.turn
    haml :maze
    end


   end
 end
