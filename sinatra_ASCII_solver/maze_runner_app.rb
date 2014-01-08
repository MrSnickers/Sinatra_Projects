#### MAZE RUNNER APP

require 'bundler'
Bundler.require

require "./lib/board_class.rb"
enable 'sessions'


module App
  class Racer< Sinatra::Application

    @@board = Board.new
    @@board.open_maze("./data/dog_maze.rb")
    @@board.set_left_start_point
    @@board.carve_path



    get'/run' do
    @@board.maze= @@board.maze.transpose
    @board = @@board

    haml :maze
    end

    # get '/run' do
    # session[:game].put_tile_back
    # session[:game].move_to_first_open_position
    # session[:game].show_mouse
    # @board = session[:game]
    # @maze = session[:game].maze
    # @open = session[:game].open_value
    # @mouse = session[:game].mouse_face
    # @visited = session[:game].visited_value
    # @path = session[:game].path_value

    # haml :maze
    # end

  end
end


# Take photo
# convert photo to ASCII
# carve maze by processing through array and swapping certain "closed" characters for "open" characters changes other "open" characters to "closed"
# run mouse that recognizes "open" values
