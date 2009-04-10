module Evil
  module Helpers
    include Evil::Models
    
    def serve(template)
      initialize_plugins
      
      template = Liquid::Template.parse(template.reload.source)
      
      content_type 'text/html', :charset => 'utf-8'
      template.render 'params' => params
    end
    
    def partial(template, options={})
      haml("_#{template}".to_sym, options.merge( :layout => false ))
    end
    
    def not_authorized(message=nil)
      status 401
      halt haml(:login)
    end
    
    def whitelisted_openid?
      session[:identity_url] && Whitelist.authorize(session[:identity_url])
    end
    
    def attempt_openid_authentication
      openid_authenticate do |result, identity_url|
        if result == :successful
          yield identity_url
        else
          not_authorized
        end
      end
    end
    
    protected
    
    def initialize_plugins
      Plugin::Environment.plugins.each { |p| p.init }
    end
    
  end
end