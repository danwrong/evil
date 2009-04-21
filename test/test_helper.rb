$:.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'rubygems'
require 'evil'
require 'test/unit'
require 'shoulda'
require 'factory_girl'
require 'sinatra/test'
require 'mocha'

require 'redgreen' rescue nil

Sinatra::Default.set :environment, 'test'
Evil.app_root = File.dirname(__FILE__)
FileUtils.rm(File.join(File.dirname(__FILE__), 'evil.db')) rescue nil
Evil::Setup::Generator.new(Evil.app_root).create_database!

Factory.sequence :number do |n|
  n.to_i
end

Factory.define :whitelist, :class => Evil::Models::Whitelist do |f|
  f.pattern 'www.example.com'
end

Factory.define :template, :class => Evil::Models::Template do |f|
  f.ttl 10
  f.position 1
  f.title { "test#{Factory.next(:number)}" }
  f.route { "/test#{Factory.next(:number)}/thing" }
  f.source 'some stuff'
end