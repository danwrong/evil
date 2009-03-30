module Evil
  module Setup
    autoload :DbTool, 'evil/setup/db_tool'
    autoload :Generator, 'evil/setup/generator'
    autoload :Migration, 'evil/setup/migration'
  end
  
  autoload :OpenID, 'evil/open_id'
  autoload :Helpers, 'evil/helpers'
  autoload :Extensions, 'evil/extensions'
  
  module Plugin
    autoload :Base, 'evil/plugin/base'
    autoload :Tag, 'evil/plugin/tag'
  end
  
  class << self
    attr_accessor :gem_root, :app_root
  end
end

Evil.gem_root = File.join(File.dirname(__FILE__), '..')