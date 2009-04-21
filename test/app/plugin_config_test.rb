require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class PluginConfigTest < Test::Unit::TestCase
  include Sinatra::Test
  
  context 'running the evil application with some plugins' do
    setup do
      @app = Evil::Application
      Evil::Plugin::Environment.stubs(:plugins).returns([])
    end
  
    
    context 'while logged in' do 
      setup do
        Factory.create(:whitelist)
        @env = { 'rack.session' => { :identity_url => 'www.example.com' } }
      end 
      
      context 'GET /admin/plugins/new' do
        setup do
          get '/admin/plugins/new', {}, @env
        end
      
        should 'be successful' do
          assert_equal 200, response.status
        end
      end   
    end
    
  end
  
end