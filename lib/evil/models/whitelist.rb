module Evil
  
  module Models
    
    class Whitelist < ActiveRecord::Base
      set_table_name :evil_whitelists
      
      validates_presence_of   :pattern
      
      after_save :clear_pattern_cache
      after_destroy :clear_pattern_cache
      
      def self.add(pattern)
        Whitelist.create! :pattern => pattern
      end
      
      def self.authorize(identity_url)
        @@patterns ||= find(:all).collect { |t| Regexp.new "^#{t.pattern.gsub('*', '(.*)')}$" }
        @@patterns.any? { |p| identity_url.gsub(/^http\:\/\//, '') =~ p }
      end
      
      protected
      
      def clear_pattern_cache
        @@patterns = nil
      end
      
    end
    
  end
  
end