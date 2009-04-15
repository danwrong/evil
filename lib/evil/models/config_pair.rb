module Evil
  
  module Models
    
    class ConfigPair < ActiveRecord::Base
      set_table_name :evil_config_pairs
      
      def self.plugins
        find_by_sql('SELECT DISTINCT(plugin) from evil_config_pairs').collect do |p|
          p.plugin
        end
      end
      
    end
    
  end
  
end