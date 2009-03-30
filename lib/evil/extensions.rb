require 'evil/models'

module Evil
  module Extensions
    
    def initialize_evil
      Sinatra.helpers  Evil::Helpers, Evil::OpenID::Helpers
      
      set :public   => File.join(Evil.app_root, 'public'),
          :views    => File.join(Evil.gem_root, 'views'),
          :haml     => { :format => :html5 }

      connect_to_database
    end
    
    def connect_to_database
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                              :database => File.join(Evil.app_root, 'evil.db')
    end
    
    def require_whitelisted_openid(pattern)
      before do
        if request.path_info =~ pattern
          unless whitelisted_openid?
            session[:destination_url] = request.url
            not_authorized
          end
        end
      end
    end
    
    def load_template_routes
      Evil::Models::Template.in_order.each do |template|
        get template.route, &proc_for(template)
      end
    end
    
    protected
    
    def proc_for(template)
      lambda { serve template }
    end
    
  end
end