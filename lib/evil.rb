module Evil
  module Setup
    autoload :DbTool, 'evil/setup/db_tool'
    autoload :Generator, 'evil/setup/generator'
    autoload :Migration, 'evil/setup/migration'
  end
  
  autoload :Application, 'evil/application'
  
  class << self
    attr_accessor :gem_root, :app_root
  end
end

Evil.gem_root = File.join(File.dirname(__FILE__), '..')