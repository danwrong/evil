require 'sinatra/base'

module Evil
  class Application < Sinatra::Base
    configure do
      register(Evil::Extensions)
      helpers(Evil::Helpers, Evil::OpenID::Helpers)

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
      @plugins = Evil::Models::ConfigPair.plugins

      haml :index
    end

    get '/admin/templates/new' do
      @template = Evil::Models::Template.new

      haml :"templates/new"
    end

    post '/admin/templates' do
      @template = Evil::Models::Template.new params[:template]

      if @template.save
        self.class.reload!
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
        self.class.reload!
        redirect '/admin'
      else
        haml :"templates/edit"
      end
    end
    
    get '/admin/plugins/new' do
      haml :"plugins/new"
    end
    
    get '/admin/plugins/:id' do
      @plugin = Evil::Plugin.find_plugin(params[:id]) rescue not_found

      haml :"plugins/edit"
    end
    
    post '/admin/plugins/:id' do
      @plugin = Evil::Plugin.find_plugin(params[:id]) rescue not_found
      
      @plugin.config.set(params[:config])
      
      redirect '/admin'
    end
  end
end
      
