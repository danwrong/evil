require 'liquid'

module Evil
  module Plugin
    
    class TagExecution
      
      def initialize(tag, options, context, &block)
        @options = evaluate(options, context)
        @context = context
        @tag = tag
        @meta = class << self; self; end
        @meta.send :define_method, :execute, &block
      end
      
      def body(locals={})
        @context.stack do
          locals.each { |k, v| @context[k.to_s] = v }
          return @tag.render_body(@context).to_s
        end
      end
      
      def to_s
        execute(@options)
      end
      
      private
      
      def evaluate(options, context)
        options.inject({}) do |evaluated, pair| 
          opt, value = pair
          evaluated[opt] = context[value]; evaluated
        end
      end
    end
    
    class Tag < Liquid::Block
      Syntax = /((#{Liquid::TagAttributes}\s?,?\s?)*)/
      
      class << self
        attr_accessor :tag_proc
        
        def from(&block)
          tag = Class.new(self)
          tag.tag_proc = block; tag
        end
      end

      def initialize(tag_name, markup, tokens)
        super
        
        if markup =~ Syntax
          @options = parse_options($1)
        else
          raise Liquid::SyntaxError.new("Syntax Error in tag '#{tagname}' - Valid syntax: #{tagname} [ opt : 'val', opt : 'val' ]")
        end
      end
      
      def render(context)
        TagExecution.new(self, @options, context, &self.class.tag_proc).to_s
      end
      
      def render_body(context)
        render_all(@nodelist, context)
      end

      private

      def parse_options(opt_string)
        pairs = opt_string.split(',')
        pairs.inject({}) do |opts, pair|
          opt, value = pair.split(':')
          opts[opt.strip.to_sym] = value.strip; opts
        end
      end
    end
    
  end
end