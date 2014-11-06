require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, 'sqlite:///app.db')

get '/about' do
  erb :about
end
