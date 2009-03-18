# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{evil}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Webb"]
  s.date = %q{2009-03-18}
  s.default_executable = %q{evil}
  s.description = %q{A simple framework for creating sites from 3rd party data and services}
  s.email = %q{dan@danwebb.net}
  s.executables = ["evil"]
  s.extra_rdoc_files = ["bin/evil", "CHANGELOG", "lib/evil/application.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/plugin.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb"]
  s.files = ["assets/config.ru", "assets/evil.css", "assets/evil.js", "bin/evil", "CHANGELOG", "lib/evil/application.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/plugin.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb", "Rakefile", "test/harness/config.ru", "test/harness/evil.db", "test/harness/public/javascripts/evil.js", "test/harness/public/stylesheets/evil.css", "test/harness/tmp/restart.txt", "Manifest", "evil.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://www.evilmashups.com}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Evil", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{evil}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple framework for creating sites from 3rd party data and services}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_runtime_dependency(%q<clip>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<clip>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<clip>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
  end
end
