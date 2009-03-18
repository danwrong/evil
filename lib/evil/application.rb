require 'sinatra'
require 'evil/models'

configure do
  set :sessions => true,
      :static   => File.join(Evil.app_root, 'public'),
      :views    => File.join(Evil.gem_root, 'views'),
      :haml     => { :format => :html5 }
      
  Sinatra.register Evil::Models
  connect_to_database
end

get '/admin' do
  haml :index
end
      
