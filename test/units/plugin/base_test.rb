require File.join(File.dirname(__FILE__), '../../test_helper')

class BaseTest < Test::Unit::TestCase
  should 'module eval given source when Evil::Plugin.evaluate called' do
    Evil::Plugin::Environment.expects(:module_eval).with('some code')
    Evil::Plugin.evaluate('some code')
  end
  
  should 'not raise if Evil::Plugin.evaluate called with dodgy code' do
    assert_nothing_raised do
      Evil::Plugin.evaluate('some code that wont work')
    end
  end
  
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
  
  should 'create and register a block tag instance when plugin initialize with a tag call' do
    Evil::Plugin::BlockTag.expects(:from).returns(t = Class.new(Evil::Plugin::BlockTag))
    Liquid::Template.expects(:register_tag).with(:thing, t)
    
    Evil::Plugin::Base.new 'Test Plugin' do |p|
      p.tag :thing, :block => true do 
        'a tag'
      end
    end
    
  end
  
  should 'create and register a singleton tag instance when plugin initialize with a tag call that passed the :block option' do
    Evil::Plugin::SingletonTag.expects(:from).returns(t = Class.new(Evil::Plugin::SingletonTag))
    Liquid::Template.expects(:register_tag).with(:thing, t)
    
    Evil::Plugin::Base.new 'Test Plugin' do |p|
      p.tag :thing do 
        'a tag'
      end
    end
    
  end
  
  
end