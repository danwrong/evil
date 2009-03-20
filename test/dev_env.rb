$:.unshift('./lib')
require 'evil'
require 'evil/models'

Evil.app_root = './test/example'

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', 
                                        :database => File.join(Evil.app_root, 'evil.db')
                                        
include Evil::Models