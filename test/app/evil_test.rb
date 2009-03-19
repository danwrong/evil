require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class EvilTest < Test::Unit::TestCase
  include Sinatra::Test
  
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
      context 'GET /admin' do
        setup do
          get '/admin', {}, { 'rack.session' => { :identity_url => 'www.danwebb.net' } }
        end

        should 'be successful' do
          assert response.ok?
        end
      end
    end
  
end