$:.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'rubygems'
require 'evil'

Evil.app_root = File.expand_path(File.dirname(__FILE__))

require 'evil/application'

run Sinatra::Application
