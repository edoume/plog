require 'rubygems'
require 'sinatra'
require 'data_mapper'
# créer la base de donnée app.db
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

class Log
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :body, Text
end

DataMapper.finalize

Log.auto_upgrade!

get '/' do
  @logs = Log.all(:order => [ :id.desc ], :limit => 20)
  erb :index
end

post '/' do
@post = Log.create(params[:log])
redirect '/'
end
