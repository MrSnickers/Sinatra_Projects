require 'bundler'
Bundler.require

require './lib/rabbit_class.rb'


class RabbitApp < Sinatra::Application

  DB = Sequel.connect('sqlite://rabbits.db')

  get '/' do
    "Why, hello there!"
  end

  # list all rabbits
  get '/rabbits' do
    @rabbits = Rabbit.all
    erb :index
  end

  # add new rabbit
  get '/rabbits/new' do
    @rabbit = Rabbit.new
    erb :new
  end

  # create new rabbit   
  post '/rabbits' do
    @rabbit = Rabbit.new(params[:rabbit])
    if @rabbit.save
      status 201
      redirect '/rabbits/' + @rabbit.id.to_s
    else
      status 400
      erb :new
    end
  end

  # edit rabbit
  get '/rabbits/edit/:id' do
    @rabbit = Rabbit.(id: params[:id])
    erb :edit
  end

    # update rabbit
  put '/rabbits/:id' do
    @rabbit = Rabbit.(:id params[:id])
    if @rabbit.update(params[:rabbit])
      status 201
      redirect '/rabbits/' + params[:id]
    else
      status 400
      erb :edit  
    end
  end

# delete rabbit confirmation
get '/rabbits/delete/:id' do
  @rabbit = Rabbit.(:id params[:id])
  erb :delete
end

# delete rabbit
delete '/rabbits/:id' do
  Rabbit.(:id params[:id]).destroy
  redirect '/rabbits'  
end

# show rabbit
get '/rabbits/:id' do
  @rabbit = Rabbit.(:id params[:id])
  erb :show
end


end