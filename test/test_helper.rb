$:.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'evil'
require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'sinatra/test'

require 'redgreen' rescue nil

Sinatra::Default.set :environment, 'test'
Evil.app_root = File.join(File.dirname(__FILE__), 'example')