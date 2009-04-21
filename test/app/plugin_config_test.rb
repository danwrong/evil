require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class PluginConfigTest < Test::Unit::TestCase
  include Sinatra::Test
  
  context 'running the evil application' do
    setup do
      @app = Evil::Application
    end
  
    
    context 'while logged in' do 
      setup do
        Factory.create(:whitelist)
        @env = { 'rack.session' => { :identity_url => 'www.example.com' } }
      end    
    end
    
  end
  
end