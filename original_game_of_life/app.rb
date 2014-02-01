require 'bundler'
Bundler.require

require './lib/cell_class.rb'
require './lib/game_class.rb'

module Life
  class Gameof < Sinatra::Application


  get '/' do
    "Hello!"
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    @@game = Game.new(20,30)
    @@game.randomize_live_cells(100)

  end

  get '/game' do
    @row_counter = 0
    @local_game = @@game
    @alive = "blue"
    @black = "transparent"
    @local_game.scan_all_cells
    @local_game.tick
    erb :game
  end


  end
end