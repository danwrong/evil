module Evil
  module Plugin
    module Environment
      class << self
        attr_reader :plugins
    
        def plugin(name, &block)
          @plugins ||= []
          @plugins << Base.new(name, &block)
        end

      end
    end
  end
end