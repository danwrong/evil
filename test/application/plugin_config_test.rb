require File.join(File.dirname(__FILE__), '../test_helper')
require 'evil/application'

class PluginConfigTest < Test::Unit::TestCase
  include Sinatra::Test
  
  context 'running the evil application' do
    setup do
      @app = Evil::Application
    end
  
    context 'and some loaded plugins ' do
      setup do
        Evil::Plugin::Environment.stubs(:plugins).returns([
          @plugin1 = Evil::Plugin::Base.new('Test Plugin') { |p|
            p.configure do |c|
              c.text :username
              c.password :password
            end
          },
          @plugin2 = Evil::Plugin::Base.new('Another Plugin') {}
        ])
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
        
          should 'display a list of plugins that are configurable' do
            assert_match /Test Plugin/, response.body
            assert_match /Another Plugin/, response.body
          end
        end 
      
        context 'GET to /admin/plugins/name' do
          setup do
            get "/admin/plugins/#{URI.escape(@plugin1.name)}", {}, @env
          end
          
          should 'be successful' do
            assert_equal 200, response.status
          end
          
          should 'render form elements' do
            assert_match /name='config\[username\]'/, response.body
            assert_match /name='config\[password\]'/, response.body
          end
        end
        
        context 'POST to /admin/plugins/name' do
          should 'update plugins config then redirect to home' do
            @plugin1.config.expects(:set).with({ 'username' => 'testies' })
            post "/admin/plugins/#{URI.escape(@plugin1.name)}", { :config => { :username => 'testies' } }, @env
            assert_equal 302, response.status
          end
        end
      end
    end
    
  end
  
end