module Evil
  module Plugin
    module Configuration
      
      class ConfigField
        
        attr_accessor :name, :type, :options
        
        def initialize(type, name, options={})
          @type, @name, @options = type, name, options
        end
        
        def label
          options[:label] || name.to_s.capitalize
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
        include Evil::Models
      
        def initialize(plugin)
          @plugin = plugin
          
          load_config!
        end
        
        def [](val)
          @values[val.to_sym]
        end
        
        def set(values)
          values.each do |k, v|
            c = ConfigPair.find_or_create_by_plugin_and_key(@plugin.name, k.to_s)
            c.update_attribute :value, v.to_s
          end if values
          
          load_config!
        end
        
        protected
        
        def load_config!
          pairs = Evil::Models::ConfigPair.find_all_by_plugin(@plugin.name)
          
          @values = pairs.inject(Hash.new('')) do |m, pair|
            m[pair.key.to_sym] = pair.value; m
          end
        end
      
      end

    end
  end
end