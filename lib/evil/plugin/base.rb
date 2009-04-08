require 'liquid'
require 'httparty'

module Evil
  module Plugin  
    class Base
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
      
      def http
        @http ||= Module.new do
          include HTTParty
        end
      end
    end
    
  end
end