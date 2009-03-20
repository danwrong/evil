require 'fileutils'
require 'evil/models'
require 'evil/setup/migration'
require 'digest/sha1'

module Evil
  module Setup
    class Generator
      include FileUtils

      ASSET_PATH = File.join(File.dirname(__FILE__), '..', '..', '..', 'assets')

      DIR_LAYOUT = %w{
        tmp
        public/images
        public/stylesheets
        public/javascripts
      }
    
      ASSETS = [
        ['evil.css', 'public/stylesheets/evil.css'],
        ['evil.js', 'public/javascripts/evil.js'],
        ['config.ru', 'config.ru']
      ]

      def initialize(path)
        @path = path
      end

      def generate!
        puts "Generating Evil application..."
        create_dir_tree!
        copy_assets!
        set_cookie_secret!
        puts "Initializing database..."
        create_database!
      end

      def create_dir_tree!
        DIR_LAYOUT.each do |dir|
          puts "Directory #{@path}/#{dir}"
          mkdir_p "#{@path}/#{dir}"
        end
      end
    
      def create_database!
        ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                                 :database => File.join(@path, 'evil.db')
                                               
        ActiveRecord::Migration.extend Evil::Setup::Migration
        
        ActiveRecord::Migration.create_evil_tables
      end
    
      def copy_assets!
        ASSETS.each do |file, dest|
          puts "File #{File.join(@path, dest)}"
          cp File.join(ASSET_PATH, file), File.join(@path, dest)
        end
      end
      
      def set_cookie_secret!
        rackup = File.read(File.join(@path, 'config.ru'))
        rackup.gsub!(/__SECRET__/, Digest::SHA1.hexdigest("__EVIL__#{Time.now.to_s}__#{rand(999999)}"))
        File.open(File.join(@path, 'config.ru'), 'w') { |f| f.write(rackup) }
      end
    end
  end
end
