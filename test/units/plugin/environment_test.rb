require File.join(File.dirname(__FILE__), '../../test_helper')

class EnvironmentTest < Test::Unit::TestCase
  include Evil::Plugin
  
  should 'take a name and block and add to plugins array' do
    Environment.instance_eval do
      @plugins = []
    end
    
    Environment.plugin :test do
    end
    
    assert_equal 1, Environment.plugins.size
    assert_kind_of Base, Environment.plugins.first
  end
end