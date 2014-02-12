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
    @@game = Game.new(22, 37)
    haml :new
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
        @@game = Game.new(22, 37)
        @@game.create_glider_gun
        redirect '/show'
      else
        redirect '/broken'
    end
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
    @census = @@game.formatted_census
    @ages = @@game.formatted_histogram
    haml :show
  end

  get '/broken' do
    haml :broken
  end

  end
end