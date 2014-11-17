require 'rubygems'
require 'pry'
require 'sinatra'
require 'data_mapper'
require 'dm-timestamps'
require 'rdiscount'
require "better_errors"
require "binding_of_caller"


configure :development do
use BetterErrors::Middleware
BetterErrors.application_root = __dir__
end

# créer la base de donnée app.db
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

#créer la table de la BDD
class Log
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
end

#mets à jour la BDD
Log.auto_upgrade!

#affiche les logs dans index
get '/' do
 	@logs = Log.all(:order => [ :id.desc ], :limit => 20)
 	erb :index
end

#créé dans la BDD via la methode post
post '/' do
	@post = Log.create(params[:log])
	redirect '/'
end

#supprimer un log de la BDD
post '/delete' do
	Log.get(params[:id]).destroy
	redirect '/'  
end

#edite un log dans la BDD
post '/edit/:id' do
	@edit = Log.get(params[:id])
	@edit.update(body: params[:log][:body])
	redirect '/'
end

#Interpreteur markdown
#à venir

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

#finalise la table de la BDD
DataMapper.finalize
