require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class EvilTest < Test::Unit::TestCase
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
          @env = { 'rack.session' => { :identity_url => 'www.danwebb.net' } }
        end
             
        context 'GET /admin' do
          setup do
            get '/admin', {}, @env
          end

          should 'be successful' do
            assert response.ok?
          end
        end
        
        context 'GET /admin/templates/1 with existing template' do
          setup do
            get '/admin/templates/1', {}, @env
          end
          
          should 'be successful' do
            assert response.ok?
          end
        end
        
        context 'GET /admin/templates/nothinghere with non-existing template' do
          setup do
            get '/admin/templates/nothinghere', {}, @env
          end
          
          should 'be not found' do
            assert_equal 404, response.status
          end
        end
      end
    end
  
end