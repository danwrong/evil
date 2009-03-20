require 'sinatra'

configure do
  Sinatra.register Evil::Extensions
  
  initialize_evil
end

require_whitelisted_openid(/^\/admin/)

get '/openid/login' do
  attempt_openid_authentication do
    session[:identity_url] = identity_url
    redirect session[:destination_url]
  end
end

post '/openid/logout' do
  session[:identity_url] = nil
  redirect '/admin'
end

get '/admin' do
  @thing = Evil::Models::Whitelist.find(:first).pattern
  haml :index
end
      
