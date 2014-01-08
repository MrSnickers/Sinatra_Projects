#### MOUSE RACER APP

require 'bundler'
Bundler.require

require "./lib/board_class"
enable 'sessions'


module App
  class Racer< Sinatra::Application

    get'/' do
    session[:board] = Board.new
    session[:board].create_maze("./data/maze.rb")
    session[:board].set_open(" ")
    session[:board].set_left_start_point
    haml :welcome
    end

    post'/run' do
    session[:board].put_tile_back
    session[:board].move_to_first_open_position
    session[:board].show_mouse
    @board = session[:board]
    @maze = session[:board].maze
    @open = session[:board].open_value
    @mouse = session[:board].mouse_face
    @visited = session[:board].visited_value
    @path = session[:board].path_value

    haml :maze
    end

    get '/run' do
    session[:board].put_tile_back
    session[:board].move_to_first_open_position
    session[:board].show_mouse
    @board = session[:board]
    @maze = session[:board].maze
    @open = session[:board].open_value
    @mouse = session[:board].mouse_face
    @visited = session[:board].visited_value
    @path = session[:board].path_value

    haml :maze
    end

   end
 end


# Take photo
# convert photo to ASCII
# carve maze by processing through array and swapping certain "closed" characters for "open" characters changes other "open" characters to "closed"
# run mouse that recognizes "open" values
