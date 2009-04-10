module Evil
  module Plugin  
    class Base
      attr_reader :name, :configurator
      
      def initialize(name, &block)
        @name = name
        @configurator = Configuration::Configurator.new
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
        yield @configurator
      end
      
      def config
        @config ||= Configuration::Config.new
      end
    end
    
  end
end