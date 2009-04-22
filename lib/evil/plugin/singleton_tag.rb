module Evil
  module Plugin
    class SingletonTag < Liquid::Tag
      include Tag
      
      def initialize(tag_name, markup, tokens)
        super
        
        set_options(markup)
      end
      
      def render(context)
        self.class.tag_proc.call(Tag.evaluate(@options, context))
      end
      
    end
  end
end