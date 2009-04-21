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
        
        context 'GET a template page' do
          setup do
            @template = Factory.create(:template)
            @app.reload!
            get @template.route
          end
          
          should 'be successful' do
            assert_equal 200, response.status
          end
          
          should 'render with text/html as default content_type' do
            assert_match /text\/html/, response.headers['Content-Type']
            assert_match /utf-8/, response.headers['Content-Type']
          end
          
          should 'set a Cache-Control header from the template\'s ttl' do
            assert_match /max-age=#{@template.ttl}/, response.headers['Cache-Control']
          end
        end
        
        context 'GET a template page with another content type set' do
          setup do
            @template = Factory.create(:template, :content_type => 'application/xml')
            @app.reload!
            get @template.route
          end
          
          should 'be successful' do
            assert_equal 200, response.status
          end
          
          should 'render with text/html as default content_type' do
            assert_match /application\/xml/, response.headers['Content-Type']
            assert_match /utf-8/, response.headers['Content-Type']
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
        
        context 'GET /admin/templates/id with existing template' do
          setup do
            @template = Factory.create(:template)
            get "/admin/templates/#{@template.id}", {}, @env
          end
          
          should 'be successful' do
            assert_equal 200, response.status
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
        
        context 'GET /admin/templates/new' do
          setup do
            get '/admin/templates/new', {}, @env
          end
          
          should 'be successful' do
            assert_equal 200, response.status
          end
        end
      end
    end
  
end