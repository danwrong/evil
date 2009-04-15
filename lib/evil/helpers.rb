module Evil
  module Helpers
    include Evil::Models
    
    def serve(template)
      initialize_plugins
      
      liquid_template = Liquid::Template.parse(template.reload.source)
      
      content_type(template.content_type || 'text/html', :charset => template.encoding || 'utf-8')
      
      if template.ttl
        headers 'Cache-Control' => "public, max-age=#{template.ttl}"
      end
      
      liquid_template.render 'params' => params
    end
    
    def partial(template, options={})
      haml(partial_name(template), options.merge( :layout => false ))
    end
    
    def render_config_field(field)
      partial("plugins/fields/#{field.type}", :locals => { :field => field })
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
    
    def urlencode(str)
      URI.escape(str)
    end
    
    protected
    
    def initialize_plugins
      Plugin::Environment.plugins.each { |p| p.init }
    end
    
    def partial_name(template_path)
      parts = template_path.to_s.split('/')
      parts[-1] = "_#{parts.last}"
      parts.join('/').to_sym
    end
  end
end