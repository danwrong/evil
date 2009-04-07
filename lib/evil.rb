module Evil
  module Setup
    autoload :DbTool, 'evil/setup/db_tool'
    autoload :Generator, 'evil/setup/generator'
    autoload :Migration, 'evil/setup/migration'
  end
  
  autoload :OpenID, 'evil/open_id'
  autoload :Helpers, 'evil/helpers'
  autoload :Extensions, 'evil/extensions'
  
  autoload :Plugin, 'evil/plugin'
  
  class << self
    attr_accessor :gem_root, :app_root
  end
end

Evil.gem_root = File.join(File.dirname(__FILE__), '..')

class Proc 
  def bind(object)
    block, time = self, Time.now
    (class << object; self end).class_eval do
      method_name = "__bind_#{time.to_i}_#{time.usec}"
      define_method(method_name, &block)
      method = instance_method(method_name)
      remove_method(method_name)
      method
    end.bind(object)
  end
end

class Object
  def instance_exec(*arguments, &block)
    block.bind(self)[*arguments]
  end
end
