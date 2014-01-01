require 'bundler'
Bundler.require

require "./lib/quiz_class.rb"

class Quizgame < Sinatra::Application

  before do
    @quiz = Quiz.new
  end


  get '/' do

  erb :quiz
  end


  post '/result' do

  erb :result
  end



end


  
# 