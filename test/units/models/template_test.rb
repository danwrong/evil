class TemplateTest < Test::Unit::TestCase
  include Evil::Models
  
  context 'with a template with a liquid syntax error' do
    setup do
      @template = Factory.build(:template, :source => '{% amissing tag %} sdkljsdh slkjdh skjldh')
    end
    
    should 'not be valid' do
      assert !@template.valid?
      assert !@template.errors[:source].nil?
    end
  end
end