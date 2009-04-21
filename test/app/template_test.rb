require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class TemplateTest < Test::Unit::TestCase
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