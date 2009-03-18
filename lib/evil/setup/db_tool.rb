require 'evil/models'

module Evil
  module Setup
    class DbTool
      include Evil::Models
      
      def initialize(app_root)
        ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                                :database => File.join(app_root, 'evil.db')
      end
      
      def whitelist(pattern)
        puts "Adding #{pattern} to admin whitelist..."
        Whitelist.create(:pattern => pattern)
      end
      
      def remove_from_whitelist(pattern)
        puts "Removing #{pattern} to admin whitelist..."
        Whitelist.find_by_pattern(pattern).destroy
      end
      
    end
  end
end