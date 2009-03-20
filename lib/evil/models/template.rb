module Evil
  
  module Models
    
    class Template < ActiveRecord::Base
      set_table_name :evil_templates
      
      validates_presence_of   :route, :source
      validates_uniqueness_of :route
      validates_format_of     :route, :with => /^((\/)|(((\/|\.):?[a-z0-9\_]+)+))$/
      
      has_many :cached_pages
      
      named_scope :in_order, :order => 'position ASC'
    end
    
  end
  
end