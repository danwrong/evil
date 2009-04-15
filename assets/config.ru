require 'rubygems'
require 'evil'

Evil.app_root = File.expand_path(File.dirname(__FILE__))

unless Evil.heroku?
  require 'rack/cache'
  
  use Rack::Cache,
    :verbose     => true,
    :metastore   => "file:#{Evil.app_root}/cache/meta",
    :entitystore => "file:#{Evil.app_root}/cache/entity"
end

use Rack::Session::Cookie, :secret => '__SECRET__', :key => '_evil'
run Evil::Application
