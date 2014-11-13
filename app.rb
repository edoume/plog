require 'rubygems'
require 'pry'
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

#<script type="text/javascript">
#	prompt("Changer votre Log ici:");
#</script>

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
