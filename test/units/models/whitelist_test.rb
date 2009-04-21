class WhitelistTest < Test::Unit::TestCase
  include Evil::Models
  
  context 'with whitelist with a non wildcarded patterm' do
    setup do
      @wl = Factory.create(:whitelist)
    end
    
    should 'only authorize that exact identity url' do
      assert !Whitelist.authorize('wwwwww.example.com')
      assert Whitelist.authorize('www.example.com')
    end
    
    should 'ignore http://' do
      assert Whitelist.authorize('http://www.example.com')
    end
  end
  
  context 'with whitelist with a wildcarded patterm' do
    setup do
      @wl = Factory.create(:whitelist, :pattern => '*.example2.com')
    end
    
    should 'authorize any identity url ending in .example2.com' do
      assert Whitelist.authorize('bob.example2.com')
      assert Whitelist.authorize('www.example2.com')
    end
  end
end