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
    erb :new
  end

  post '/create' do
    case params[:game_type]
      when "free_hand"
        erb :edit
      when "pulsar"
        @@game = Game.new(20,20)
        @@game.create_pulsar
        redirect '/show'
      when "glider_gun"
        @@game = Game.new(20,20)
        @@game.create_glider_gun
        redirect '/show'
      else
        redirect '/broken'
    end
  end

  get '/edit' do

  end

  get '/broken' do
    erb :broken
  end

  get '/show' do
    @row_counter = 0
    @local_game = @@game
    @local_game.scan_all_cells
    @local_game.tick
    erb :show
  end

  end
end