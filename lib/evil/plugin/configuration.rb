module Evil
  module Plugin
    module Configuration
      
      class ConfigField
        
        attr_accessor :name, :type, :options
        
        def initialize(type, name, options={})
          @type, @name, @options = type, name, options
        end
        
      end
      
      class Configurator
        
        attr_reader :fields
        
        def initialize
          @fields = []
        end
        
        def text(field, options={})
          @fields << ConfigField.new(:text, field, options)
        end
        
        def password(field, options={})
          @fields << ConfigField.new(:password, field, options)
        end
        
      end
      
      class Config
      
        def initialize(plugin)
          pairs = Evil::Models::ConfigPair.find_all_by_plugin(plugin.name)
          
          if pairs
            @values = pairs.inject(Hash.new('')) do |m, pair|
              m[pair.key.to_sym] = pair.value; m
            end
          else
            @values = Hash.new('')
          end
        end
        
        def [](val)
          @values[val.to_sym]
        end
      
      end

    end
  end
end