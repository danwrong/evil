require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class OpenidTest < Test::Unit::TestCase
  include Sinatra::Test
  
  context 'running the evil application' do
    setup do
      @app = Evil::Application
    end
  
    context 'while not logged in' do
      
        context 'GET /admin' do
          setup do
            get '/admin'
          end
        
          should 'not be authorized' do
            assert_equal 401, response.status
            assert_match /openid_url/, response.body
          end
        end
      end
        
    
      context 'while logged in' do 
        setup do
          Factory.create(:whitelist)
          @env = { 'rack.session' => { :identity_url => 'www.example.com' } }
        end
             
        context 'GET /admin' do
          setup do
            get '/admin', {}, @env
          end

          should 'be successful' do
            assert response.ok?
          end
        end
      end
    end
  
end