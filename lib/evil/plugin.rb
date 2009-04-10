module Evil
  module Plugin
    autoload :Base, 'evil/plugin/base'
    autoload :Tag, 'evil/plugin/tag'
    autoload :Environment, 'evil/plugin/environment'
    autoload :Filesystem, 'evil/plugin/filesystem'
    
    def self.evaluate(plugin_source)
      Environment.module_eval plugin_source
    end
    
    def self.from_file(file)
      evaluate(File.read(file))
    end
  end
end