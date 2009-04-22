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
      
      context 'POST /admin/templates/id with valid updated attributes' do
        setup do
          @template = Factory.create(:template)
          post "/admin/templates/#{@template.id}", { :template => { :title => 'thing' } }, @env
        end
        
        should 'redirect to admin home' do
          assert_equal 302, response.status
        end
        
        should 'update values' do
          assert_equal 'thing', @template.reload.title
        end
      end
      
      should 'reload app on POST /admin/templates/id with valid updated attributes' do
        @template = Factory.create(:template)
        @app.expects(:reload!)
        post "/admin/templates/#{@template.id}", { :template => { :title => 'thing' } }, @env
      end
      
      context 'POST /admin/templates/id with invalid updated attributes' do
        setup do
          @template = Factory.create(:template)
          post "/admin/templates/#{@template.id}", { :template => { :title => '' } }, @env
        end
        
        should 'render form' do
          assert_equal 200, response.status
        end
      end
      
      context 'POST /admin/templates with valid attributes' do
        setup do
          post "/admin/templates", { :template => { 
            :title => 'just created',
            :source => 'some stuff',
            :ttl => 10
          } }, @env
        end
        
        should 'create record' do
          assert Evil::Models::Template.find_by_title('just created')
        end
        
        should 'redirect to admin home' do
          assert_equal 302, response.status
        end
      end
      
      context 'POST /admin/templates with valid attributes' do
        setup do
          post "/admin/templates", { :template => { 
            :title => nil,
            :source => 'some stuff',
            :ttl => 10
          } }, @env
        end
        
        should 'render form' do
          assert_match /template\[source\]/, response.body
        end
        
        should 'be successful' do
          assert_equal 200, response.status
        end
      end
    end
  end
  
end