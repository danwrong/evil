module Evil
  
  module Models
    
    class Plugin < ActiveRecord::Base
      set_table_name :evil_plugins
      
      has_many :config_pairs
    end
    
  end
  
end