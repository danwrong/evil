class BaseTest < Test::Unit::TestCase
  should 'initialize with a name and a block that recieves the new instance' do
    plugin = Evil::Plugin::Base.new 'Test Plugin' do |p|
      assert_instance_of Evil::Plugin::Base, p
    end
    
    assert_equal 'Test Plugin', plugin.name
  end
  
  context 'given a plugin instance' do
    setup do
      @setup_proc = Proc.new {}
      
      @plugin = Evil::Plugin::Base.new 'Test Plugin' do |p|
        p.description 'A plugin for testing plugins'

        p.tag :thing do |args|
          'test'
        end

        p.filter :thing do
          'test'
        end
        
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
end