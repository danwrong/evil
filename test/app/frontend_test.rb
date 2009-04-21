require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class FrontendTest < Test::Unit::TestCase
  include Sinatra::Test
  
  context 'running the evil application' do
    setup do
      @app = Evil::Application
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
  
end