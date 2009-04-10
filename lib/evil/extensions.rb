require 'evil/models'

module Evil
  module Extensions
    
    def initialize_evil
      set :public   => File.join(Evil.app_root, 'public'),
          :views    => File.join(Evil.gem_root, 'views'),
          :haml     => { :format => :html5 },
          :logging  => true,
          :static   => true
          
      Liquid::Template.file_system = Evil::Plugin::Filesystem.new

      connect_to_database
      load_all_plugins
    end
    
    def connect_to_database
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                              :database => File.join(Evil.app_root, 'evil.db')
    end
    
    def load_template_routes
      Evil::Models::Template.in_order.each do |template|
        get(template.route, &proc_for(template)) unless template.route.nil? || template.route.empty?
      end
    end
    
    def load_all_plugins
      Dir[File.join(Evil.gem_root, 'lib', 'plugin/builtin', '*.rb')].each do |plugin|
        Evil::Plugin.from_file(plugin)
      end
      
      Dir[File.join(Evil.app_root, 'plugins', '*.evil')].each do |plugin|
        Evil::Plugin.from_file(plugin)
      end
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
    
    protected
    
    def proc_for(template)
      lambda { serve template }
    end
    
  end
end