require 'bundler'
Bundler.require

require './lib/cell_class.rb'
require './lib/game_class.rb'

module Life
  class Gameof < Sinatra::Application
    @@game = Game.new(20,20)

  get '/' do
    "Hello!"
  end

  get '/new' do
    @local_game = @@game
    erb :new
  end

  post '/create' do
    case params[:game_type]
      when "random"
        @@game.randomize_live_cells(100)
        redirect '/show'
      when "free_hand"
        redirect '/edit'
      when "pulsar"
        @@game.create_pulsar
        redirect '/show'
      when "glider_gun"
        @@game = Game.new(28, 40)
        @@game.create_glider_gun
        redirect '/show'
      else
        redirect '/broken'
    end
  end

  get '/edit' do
    @local_game = @@game
    erb :edit
  end

  post '/update' do
    erb :broken
  end

  get '/broken' do
    erb :broken
  end

  get '/show' do
    @row_counter = 0
    @local_game = @@game
    @local_game.scan_all_cells
    @local_game.tick
    @ages = @@game.sort_histogram
    erb :show
  end

  end
end