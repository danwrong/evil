require 'sinatra'

configure do
  Sinatra.register Evil::Extensions
  
  initialize_evil
end

require_whitelisted_openid(/^\/admin/)
load_template_routes

get '/openid/login' do
  attempt_openid_authentication do |identity_url|
    session[:identity_url] = identity_url
    redirect session[:destination_url]
  end
end

post '/openid/logout' do
  session[:identity_url] = nil
  redirect '/admin'
end

get '/admin' do
  @templates = Evil::Models::Template.in_order
  @plugins = Evil::Models::Plugin.all
  
  haml :index
end

get '/admin/templates/new' do
  @template = Evil::Models::Template.new
  
  haml :"templates/new"
end

post '/admin/templates' do
  @template = Evil::Models::Template.new params[:template]
  
  if @template.save
    redirect '/admin'
  else
    haml :"templates/new"
  end
end

get '/admin/templates/:id' do
  @template = Evil::Models::Template.find(params[:id]) rescue not_found
  
  haml :"templates/edit"
end

post '/admin/templates/:id' do
  @template = Evil::Models::Template.find(params[:id]) rescue not_found
  
  @template.attributes = params[:template]
  
  if @template.save
    redirect '/admin'
  else
    haml :"templates/edit"
  end
end
      
