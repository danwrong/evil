require 'echoe'
require 'fileutils'

Echoe.new("evil") do |p|
  p.author = "Dan Webb"
  p.email = 'dan@danwebb.net'
  p.summary = "A simple framework for creating sites from 3rd party data and services"
  p.url = "http://www.evilmashups.com"
  p.runtime_dependencies = ["sinatra >= 0.9.1.1", "activerecord >= 2.3.2",
                            "sqlite3-ruby >= 1.2.1", "clip >= 1.0.0", 
                            "haml >= 2.0.9", "liquid >= 2.0.0", 
                            "danwrong-liquid-inheritance >= 0.1.1", "rack-cache >= 0.4"]
                            
  p.development_dependencies = ['shoulda']
  p.retain_gemspec = true
  p.ignore_pattern = ['test/example/**/*', 'test/evil.db']
  p.rcov_options = "--exclude 'gems/*'"
end

desc 'Move assets from text/example to assets'
task :sync_assets do
  ['test/example/public/images/*', 'test/example/public/stylesheets/*', 
   'test/example/public/javascripts/*'].each do |glob|
    FileUtils.cp Dir[glob], 'assets/'
  end
end

desc 'Open a irb session with Evil loaded in the context of test/example'
task :dev_console do
  exec 'irb -r test/dev_env'
end
