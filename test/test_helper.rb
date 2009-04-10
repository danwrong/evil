$:.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'rubygems'
require 'evil'
require 'test/unit'
require 'shoulda'
require 'sinatra/test'
require 'mocha'

require 'redgreen' rescue nil

Sinatra::Default.set :environment, 'test'
Evil.app_root = File.join(File.dirname(__FILE__), 'example')