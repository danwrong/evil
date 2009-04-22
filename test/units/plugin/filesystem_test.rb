require File.join(File.dirname(__FILE__), '../../test_helper')

class FilesystemTest < Test::Unit::TestCase
  include Evil::Plugin
  
  context 'given an instance of the filesystem' do
    setup do
      @template = Factory.create(:template, :title => 'boom', :source => 'boom source')
      @fs = Filesystem.new
    end
    
    should 'return source of a template with the given title' do
      assert_equal 'boom source', @fs.read_template_file('boom')
    end
    
    should 'raise an exception of template not found' do
      assert_raises(Liquid::FileSystemError) do
        @fs.read_template_file('nothinghere')
      end
    end
  end
end