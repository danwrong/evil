module Evil
  module Plugin
    
    class TagExecution
      
      def initialize(tag, options, context, &block)
        @options = Tag.evaluate(options, context)
        @context = context
        @tag = tag
        @proc = block
      end
      
      def body(locals={})
        @context.stack do
          locals.each { |k, v| @context[k.to_s] = v }
          return @tag.render_body(@context).to_s
        end
      end
      
      def execute
        self.instance_exec(@options, &@proc)
      end
      
      def to_s
        execute.to_s
      end
    end
    
    class BlockTag < Liquid::Block
      include Tag
      
      def initialize(tag_name, markup, tokens)
        super
        
        set_options(markup)
      end
      
      def render(context)
        TagExecution.new(self, @options, context, &self.class.tag_proc).to_s
      end
      
      def render_body(context)
        render_all(@nodelist, context)
      end
    end
    
  end
end