$:.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'rubygems'
require 'evil'

Evil.app_root = File.expand_path(File.dirname(__FILE__))

use Rack::Session::Cookie, :secret => '4424427c834b0c67f38f40a977315480b75ce94b', :key => '_evil'

unless Evil.heroku?
  require 'rack/cache'
  
  use Rack::Cache,
    :verbose     => true,
    :metastore   => "file:#{Evil.app_root}/cache/meta",
    :entitystore => "file:#{Evil.app_root}/cache/entity"
end

run Evil::Application