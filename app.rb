require 'rubygems'
require 'sinatra'
require 'data_mapper'
require "better_errors"
# créer la base de donnée app.db
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

#créer la table de la BDD
class Log
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :body, Text
end

#finalise la table de la BDD
DataMapper.finalize

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

#Log.update(:body => "new text here")
#Log.delete(:id??)


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
