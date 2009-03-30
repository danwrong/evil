require 'liquid'

module Evil
  module Plugin
    
    class Base < Module
            
      def tag(name, &block)
        tag = Tag.from(&block)
        Liquid::Template.register_tag(name, tag)
      end
      
      def filter(name, &block)
      
      end
      
    end
    
  end
end