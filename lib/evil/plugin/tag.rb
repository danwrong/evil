module Evil
  module Plugin
    module Tag
      Syntax = /((#{Liquid::TagAttributes}\s?,?\s?)*)/
      
      def self.included(base)
        base.instance_eval do
          def from(&block)
            tag = Class.new(self)
            
            class << tag
              attr_accessor :tag_proc
            end
            
            tag.tag_proc = block; tag
          end
        end
      end
      
      def self.evaluate(options, context)
        options.inject({}) do |evaluated, pair| 
          opt, value = pair
          evaluated[opt] = context[value]; evaluated
        end
      end
      
      protected
      
      def set_options(markup)
        if markup =~ Syntax
          @options = parse_options($1)
        else
          raise Liquid::SyntaxError.new("Syntax Error in tag '#{tagname}' - Valid syntax: #{tagname} [ opt : 'val', opt : 'val' ]")
        end
      end
      
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