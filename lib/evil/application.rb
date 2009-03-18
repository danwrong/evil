require 'sinatra'
require 'evil/models'

configure do
  Sinatra.register Evil::Models
  
  set :sessions => true,
      :public   => File.join(Evil.app_root, 'public'),
      :views    => File.join(Evil.gem_root, 'views'),
      :haml     => { :format => :html5 }
      
  connect_to_database
end

include Evil::Models

get '/admin' do
  @thing = Whitelist.find(:first).pattern
  haml :index
end
      
