require 'rubygems'
require 'evil'

Evil.app_root = File.expand_path(File.dirname(__FILE__))

use Rack::Session::Cookie, :secret => '__SECRET__', :key => '_evil'
run Evil::Application
