#### MOUSE RACER APP

require 'bundler'
Bundler.require

require "./lib/board_class"
enable 'sessions'


module App
  class Racer< Sinatra::Application

    get'/run' do
    session[:board] = Board.new
    session[:board].create_maze("./data/maze.rb")
    session[:board].set_open(" ")
    session[:board].make_mice(2)
    6.times do
        turn
    end
    haml :maze
    end


   end
 end


# Take photo
# convert photo to ASCII
# carve maze by processing through array and swapping certain "closed" characters for "open" characters changes other "open" characters to "closed"
# run mouse that recognizes "open" values
