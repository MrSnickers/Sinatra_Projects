require 'bundler'
Bundler.require

require './lib/cell_class.rb'
require './lib/game_class.rb'

module Life
  class Gameof < Sinatra::Application

  APP_ROOT = File.dirname(__FILE__)

  get '/' do
    "Hello!"
  end

  get '/new' do
    @@game = Game.new(22, 37)
    haml :new
  end

  post '/create' do
    @local_game = @@game
    @row_counter = 0
    case params[:game_type]
      when "random"
        @@game.randomize_live_cells(150)
        haml :show
      when "free_hand"
        redirect '/edit'
      when "blinker"
        @@game.create_blinker
        haml :show
      when "pulsar"
        @@game.create_pulsar
        haml :show
      when "glider_gun"
        @@game = Game.new(22, 37)
        @@game.create_glider_gun
        haml :show
      else
        redirect '/broken'
    end
  end

  get '/create' do
    redirect '/show'    
  end

  get '/edit' do
    @local_game = @@game
    haml :edit
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
    haml :show
  end

  get '/update' do
    redirect '/show'
  end

  get '/show' do
    @row_counter = 0
    @local_game = @@game
    @local_game.scan_all_cells
    @local_game.tick
    @local_game.record_census
    @local_game.record_histogram
    @census = @@game.formatted_census
    @ages = @@game.formatted_histogram
    haml :show
  end

  get '/reckoning' do
    @@game.reckoning
    @row_counter = 0
    @local_game = @@game
    haml :show
  end

  get '/broken' do
    haml :broken
  end

  end
end