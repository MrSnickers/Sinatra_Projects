#### MAZE RUNNER APP

require 'bundler'
Bundler.require

require "./lib/board_class"
# enable 'sessions'


module App
  class Racer< Sinatra::Application

    get'/' do
    "welcome"
    end

    get'/run' do
    session[:board] = Board.new
    session[:board].create_maze("./data/maze.rb")
    @maze = session[:board].maze

    haml :maze
    end

   end
 end
