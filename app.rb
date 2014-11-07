require 'rubygems'
require 'sinatra'
require 'data_mapper'
require "better_errors"
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

helpers do
	def color(name)
		if name == 'Mathieu'
			'panel-primary'
		elsif name == 'Édouard'
			'panel-success'
		else			
			'panel-danger'
		end
	end
end

