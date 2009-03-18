require 'activerecord'
require 'evil/models/config_pair'
require 'evil/models/plugin'
require 'evil/models/template'
require 'evil/models/whitelist'

module Evil
  module Models

    def connect_to_database
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                              :database => File.join(Evil.app_root, 'evil.db')
    end

  end
end

