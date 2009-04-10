module Evil
  
  module Models
    
    class Template < ActiveRecord::Base
      set_table_name :evil_templates
      
      validates_presence_of   :title, :source
      validates_uniqueness_of :route, :if => lambda { |template| !(template.route.empty? || template.route.nil?) }
      validates_format_of     :route, :with => /^((\/)|(((\/|\.):?[a-z0-9\_]+)+))$/, 
                                      :allow_blank => true, :allow_nil => true
      validate :liquid_syntax
      
      has_many :cached_pages
      
      named_scope :in_order, :order => 'position ASC'
      
      private
      
      def liquid_syntax
        Liquid::Template.parse(source)
      rescue Liquid::SyntaxError => error
        errors.add(:source, "has syntax error: #{error.message}")
      end
    end
    
  end
  
end