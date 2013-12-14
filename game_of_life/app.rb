require 'bundler'
Bundler.require
require "rainbow"

require "./lib/game_class"
require "./lib/cell_class"

module Name
  class App < Sinatra::Application
    @@game = Game.new(80, 80)

    get '/' do
      "Welcome to the Game of Life"
    end

    get '/game' do
      @local_game = @@game
      @local_game.randomize_live_cells(100)
      @local_game.tick
      erb :game
    end


  end
end
