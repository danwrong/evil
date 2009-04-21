require File.join(File.dirname(__FILE__), '../../test_helper')

class BaseTest < Test::Unit::TestCase
  should 'initialize with a name and a block that recieves the new instance' do
    plugin = Evil::Plugin::Base.new 'Test Plugin' do |p|
      assert_instance_of Evil::Plugin::Base, p
    end
    
    assert_equal 'Test Plugin', plugin.name
  end
  
  context 'given a plugin instance with a description and setup set' do
    setup do
      @setup_proc = Proc.new {}
      
      @plugin = Evil::Plugin::Base.new 'Test Plugin' do |p|
        p.description 'A plugin for testing plugins'
        
        p.setup &@setup_proc

      end
    end
    
    should 'have a description set' do
      assert_equal 'A plugin for testing plugins', @plugin.description
    end
    
    should 'call the setup proc when init called' do
      @setup_proc.expects(:call)
      
      @plugin.init
    end
    
  end
  
  should 'create and register a tag instance when plugin initialize with a tag call' do
    Evil::Plugin::Tag.expects(:from).returns(t = Class.new(Liquid::Tag))
    Liquid::Template.expects(:register_tag).with(:thing, t)
    
    Evil::Plugin::Base.new 'Test Plugin' do |p|
      p.tag :thing do 
        'a tag'
      end
    end
    
  end
  
  
end