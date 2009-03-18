require 'ar_openid_store'
require 'ar_openid_store/migration'

module Evil
  module Setup
    module Migration
      
      def create_evil_tables
        create_table :evil_templates do |t|
          t.integer :ttl, :position
          t.string  :title, :route
          t.text    :source
          t.timestamps
        end unless Evil::Models::Template.table_exists?
        
        create_table :evil_plugins do |t|
          t.string  :name, :description, :author
          t.text    :source, :url
          t.boolean :enabled
          t.timestamps
        end unless Evil::Models::Plugin.table_exists?
        
        unless Evil::Models::ConfigPair.table_exists?
          create_table :evil_config_pairs do |t|
            t.integer :plugin_id
            t.string  :key
            t.text    :value
            t.timestamps
          end
          
          add_index :evil_config_pairs, :plugin_id
        end
        
        create_table :evil_whitelists do |t|
          t.string :pattern
        end unless Evil::Models::Whitelist.table_exists?
        
        unless ArOpenidStore::Association.table_exists?
          create_openid_tables
        end
      end
      
      def destroy_evil_tables
        drop_table :evil_templates
        drop_table :evil_plugins
        drop_table :evil_config_pairs
        drop_openid_tables
      end
      
    end
  end
end
      
      