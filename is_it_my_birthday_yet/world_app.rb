require 'bundler'
Bundler.require

class TestApp < Sinatra::Application

get '/hi' do
  @breaker = ["Ashley","Blake"].sample
    erb :index #needs to be at the end as the return value
  end

  get '/Sterling' do
    "That was tasty cake!"
  end

end