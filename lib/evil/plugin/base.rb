require 'liquid'
require 'httparty'

module Evil
  module Plugin  
    class Base
      include HTTParty
      attr_reader :name, :description
      
      def initialize(name, &block)
        @name = name
        block.call(self)
      end
      
      def description(desc)
        @description = desc
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
      
      def get(*args)
        self.class.get(*args)
      end
      
      def post(*args)
        self.class.post(*args)
      end
      
      def put(*args)
        self.class.put(*args)
      end
      
      def delete(*args)
        self.class.delete(*args)
      end
      
      def base_uri(*args)
        self.class.base_uri(*args)
      end
      
      def basic_auth(*args)
        self.class.basic_auth(*args)
      end
    end
    
  end
end