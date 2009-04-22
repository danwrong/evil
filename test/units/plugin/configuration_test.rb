require File.join(File.dirname(__FILE__), '../../test_helper')

class ConfigurationTest < Test::Unit::TestCase
  include Evil::Plugin
  
  context 'with an instance of Config' do
    setup do
      Evil::Models::ConfigPair.destroy_all
      
      Factory.create(:config_pair, :key => 'boob', :value => 'test')
      Factory.create(:config_pair, :key => 'beeb', :value => 'hello')
      
      @plugin = Base.new('Test') do |p|
        p.configure do |c|
          c.text :username
          c.password :password
        end
      end
      
      @config = Configuration::Config.new(@plugin)
    end
    
    should 'return a value for an existing key' do
      assert_equal 'test', @config['boob']
    end
    
    should 'also allow access through symbols' do
      assert_equal 'test', @config[:boob]
    end
    
    should 'return an empty string for unset values' do
      assert_equal '', @config['nothinghere']
    end
    
    should 'allow you to set values with a hash' do
      @config.set( :new => 'blah' )
      
      assert_equal 'blah', @config[:new]
    end
    
    should 'allow you to update values with a hash' do
      @config.set( :beeb => 'not test' )
      
      assert_equal 'not test', @config[:beeb]
    end
    
    should 'return empty strings for an unconfigured plugin' do
      plugin2 = Base.new('Splange') do |p|
        p.configure do |c|
          c.text :username
          c.password :password
        end
      end
      
      config2 = Configuration::Config.new(plugin2)
      
      assert_equal '', config2[:something]
    end
  end
end