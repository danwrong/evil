module Evil
  module Plugin  
    class Base
      attr_reader :name
      
      def initialize(name, &block)
        @name = name
        block.call(self)
      end

      def init
        @setup_proc.call if @setup_proc
      end
      
      def description(desc=nil)
        @description = desc if desc
        @description
      end
      
      def setup(&block)
        @setup_proc = block
      end
                  
      def tag(name, &block)
        tag = Tag.from(&block)
        Liquid::Template.register_tag(name, tag)
      end
      
      def filter(fname, &block)
        mod = Module.new do
          define_method(fname, &block)
        end
        
        mod.module_eval "def self.name; \"_filter_#{fname}\"; end"
        
        Liquid::Template.register_filter(mod)
      end
      
      def http
        @http ||= Module.new do
          include HTTParty
        end
      end
      
      def configure
        @configurator ||= Configuration::Configurator.new
        yield @configurator
      end
      
      def config
        @config ||= Configuration::Config.new
      end
    end
    
  end
end