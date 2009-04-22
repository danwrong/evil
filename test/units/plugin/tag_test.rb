require File.join(File.dirname(__FILE__), '../../test_helper')
require 'liquid'

class TagTest < Test::Unit::TestCase
  context 'with a custom block tag defined that returns a string' do
    setup do
      Liquid::Template.register_tag('test', Evil::Plugin::BlockTag.from { |params|
        'hello'
      })
    end
    
    should 'output the string' do
      template = Liquid::Template.parse('{% test %}{% endtest %}')

      assert_equal 'hello', template.render
    end
  end
  
  context 'with a custom tag defined that returns a parameter' do
    setup do
      Liquid::Template.register_tag('test', Evil::Plugin::BlockTag.from { |params|
        params[:a]
      })
    end
    
    should 'output that parameter if passed as a constant' do
      template = Liquid::Template.parse('{% test a: "thing" %}{% endtest %}')
      
      assert_equal 'thing', template.render
    end
    
    should 'output that parameter if passed as a variable' do
      template = Liquid::Template.parse('{% test a: var %}{% endtest %}')
      
      assert_equal 'thing', template.render('var' => 'thing')
    end
  end
  
  context 'with a custom tag defined that uses the body method' do
    setup do
      Liquid::Template.register_tag('test', Evil::Plugin::BlockTag.from { |params|
        times = params[:times] || 1
        out = ''
        times.times { |i| out << body(:i => i) }
        out
      })
    end
    
    should 'output the contents of the tag' do
      template = Liquid::Template.parse('{% test %}a{% endtest %}')
      
      assert_equal 'a', template.render
    end
    
    should 'remember the i variable passed to body' do
      template = Liquid::Template.parse('{% test %}{{ i }}{% endtest %}')
      
      assert_equal '0', template.render
    end
    
    should 'be different value of i for each repetition of body' do
      template = Liquid::Template.parse('{% test times: 10 %}{{ i }}{% endtest %}')
      
      assert_equal '0123456789', template.render
    end
  end
  
  context 'with 2 custom tags defined' do
    setup do
      Liquid::Template.register_tag('test', Evil::Plugin::BlockTag.from { |params|
        times = params[:times] || 1
        out = ''
        times.times { |i| out << body(:i => i) }
        out
      })
      
      Liquid::Template.register_tag('test2', Evil::Plugin::BlockTag.from { |params|
        params[:a]
      })
    end
    
    should 'be able to nest tags' do
      template = Liquid::Template.parse("{% test times: 2 %}{% test2 a: 4 %}{% endtest2 %}{% endtest %}")
      
      assert_equal '44', template.render
    end
    
    should 'be able to use vars from outer tag in inner tag' do
      template = Liquid::Template.parse("{% test times: 2 %}{% test2 a: i %}{% endtest2 %}{% endtest %}")
      
      assert_equal '01', template.render
    end
  end
  
  context 'with a custom tag with more than one parameter defined' do
    setup do
      Liquid::Template.register_tag('test', Evil::Plugin::BlockTag.from { |params|
        [params[:a], params[:b]].join('|')
      })
    end
    
    should 'output both parameters' do
      template = Liquid::Template.parse("{% test a: 'g', b: 'a' %}{% endtest %}")
      
      assert_equal 'g|a', template.render
    end
  end
  
  
  context 'with a custom singleton tag defined that returns a string' do
    setup do
      Liquid::Template.register_tag('tests', Evil::Plugin::SingletonTag.from { |params|
        'hello'
      })
    end
    
    should 'output the string' do
      template = Liquid::Template.parse('{% tests %}')

      assert_equal 'hello', template.render
    end
  end
  
  context 'with a custom singleton tag defined that uses a parameter' do
    setup do
      Liquid::Template.register_tag('tests', Evil::Plugin::SingletonTag.from { |params|
        params[:thing]
      })
    end
    
    should 'output the parameter' do
      template = Liquid::Template.parse('{% tests thing: "boo" %}')

      assert_equal 'boo', template.render
    end
  end
end