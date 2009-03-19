require 'sinatra'
require 'evil/models'

configure do
  Sinatra.register Evil::Models
  Sinatra.helpers  Evil::OpenID::Helpers
  
  set :sessions => true,
      :public   => File.join(Evil.app_root, 'public'),
      :views    => File.join(Evil.gem_root, 'views'),
      :haml     => { :format => :html5 }
      
  connect_to_database
  
  include Evil::Models
end

before do
  if request.path_info =~ /^\/admin/
    unless session[:identity_url] && Whitelist.authorize(session[:identity_url])
      session[:destination_url] = request.url
      status 401
      halt haml(:login)
    end
  end
end

get '/openid/login' do
  openid_authenticate do |result, identity_url|
    if result == :successful
      session[:identity_url] = identity_url
      redirect session[:destination_url]
    else
      status 401
      halt haml(:login)
    end
  end
end

post '/openid/logout' do
  session[:identity_url] = nil
  redirect '/admin'
end

get '/admin' do
  @thing = Whitelist.find(:first).pattern
  haml :index
end
      
