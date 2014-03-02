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
    @@game = Game.new(15,22)
    erb :new
  end

  post '/create' do
    @local_game = @@game
    @row_counter = 0   
    case params[:game_type]
      when "random"
        @@game.randomize_live_cells(150)
        erb :show
      when "pulsar"
        @@game = Game.new(20,20)
        @@game.create_pulsar
        redirect '/show'
      when "blinker"
        @@game.create_blinker
        redirect '/show'
      else
        redirect '/broken'
    end
  end

  get '/create' do
    redirect '/show'
  end

  get '/edit' do
    @local_game = @@game
    erb :edit

  end

  post '/update' do
    params.each do |key, value|
      value.each do |x, inner_hash|
        inner_hash.each do |y, value|
          @@game.board[x.to_i][y.to_i].alive = true
          @@game.board[x.to_i][y.to_i].age = 1
        end
      end
    end
    @row_counter = 0
    @local_game = @@game
    erb :show
  end

  get '/update' do
    redirect '/show'
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