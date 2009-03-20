$:.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'rubygems'
require 'evil'

Evil.app_root = File.expand_path(File.dirname(__FILE__))

require 'evil/application'

use Rack::Session::Cookie, :secret => '4424427c834b0c67f38f40a977315480b75ce94b', :key => '_evil'
run Sinatra::Application
