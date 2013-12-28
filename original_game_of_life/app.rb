require 'bundler'
Bundler.require

require './lib/cell_class.rb'
require './lib/game_class.rb'

module Life
  class Gameof < Sinatra::Application

    @@game = Game.new(20,20)
    @@game.randomize_live_cells(200)

  get '/' do
    "Hello!"
  end

  get '/game' do
    @row_counter = 0
    @local_game = @@game
    @alive = "background: linear-gradient(135deg, rgba(248,80,50,1) 0%,rgba(241,111,92,1) 43%,rgba(246,41,12,1) 58%,rgba(240,47,23,1) 71%,rgba(231,56,39,1) 100%);"
    @black = "background-color: black"
    @local_game.scan_all_cells
    @local_game.tick
    erb :game
  end


  end
end