module Evil
  module Plugin
    autoload :Base, 'evil/plugin/base'
    autoload :Tag, 'evil/plugin/tag'
    autoload :BlockTag, 'evil/plugin/block_tag'
    autoload :SingletonTag, 'evil/plugin/singleton_tag'
    autoload :Environment, 'evil/plugin/environment'
    autoload :Filesystem, 'evil/plugin/filesystem'
    autoload :Configuration, 'evil/plugin/configuration'
    
    def self.evaluate(plugin_source)
      Environment.module_eval plugin_source
    rescue
      nil
    end
    
    def self.from_file(file)
      evaluate(File.read(file))
    end
    
    def self.find_plugin(name)
      Environment.plugins.find { |p| p.name == name }
    end
  end
end