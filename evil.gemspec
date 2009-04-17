# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{evil}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Webb"]
  s.date = %q{2009-04-17}
  s.default_executable = %q{evil}
  s.description = %q{A simple framework for creating sites from 3rd party data and services}
  s.email = %q{dan@danwebb.net}
  s.executables = ["evil"]
  s.extra_rdoc_files = ["bin/evil", "CHANGELOG", "lib/evil/application.rb", "lib/evil/extensions.rb", "lib/evil/helpers.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/open_id.rb", "lib/evil/plugin/base.rb", "lib/evil/plugin/configuration.rb", "lib/evil/plugin/environment.rb", "lib/evil/plugin/filesystem.rb", "lib/evil/plugin/tag.rb", "lib/evil/plugin.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb", "LICENSE", "README.textile"]
  s.files = ["assets/config.ru", "assets/evil-lib.js", "assets/evil.css", "assets/evil.js", "assets/logo.png", "bin/evil", "CHANGELOG", "evil.gemspec", "lib/evil/application.rb", "lib/evil/extensions.rb", "lib/evil/helpers.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/open_id.rb", "lib/evil/plugin/base.rb", "lib/evil/plugin/configuration.rb", "lib/evil/plugin/environment.rb", "lib/evil/plugin/filesystem.rb", "lib/evil/plugin/tag.rb", "lib/evil/plugin.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb", "LICENSE", "Manifest", "Rakefile", "README.textile", "test/app/evil_test.rb", "test/dev_env.rb", "test/test_helper.rb", "test/units/plugin/base_test.rb", "test/units/plugin/tag_test.rb", "views/_banner.haml", "views/_errors.haml", "views/index.haml", "views/layout.haml", "views/login.haml", "views/plugins/_fields.haml", "views/plugins/edit.haml", "views/plugins/fields/_password.haml", "views/plugins/fields/_text.haml", "views/plugins/new.haml", "views/templates/_fields.haml", "views/templates/edit.haml", "views/templates/new.haml"]
  s.has_rdoc = true
  s.homepage = %q{http://www.evilmashups.com}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Evil", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{evil}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple framework for creating sites from 3rd party data and services}
  s.test_files = ["test/app/evil_test.rb", "test/test_helper.rb", "test/units/plugin/base_test.rb", "test/units/plugin/tag_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0", "= 0.9.1.1"])
      s.add_runtime_dependency(%q<activerecord>, [">= 0", "= 2.3.2"])
      s.add_runtime_dependency(%q<sqlite3-ruby>, [">= 0", "= 1.2.1"])
      s.add_runtime_dependency(%q<clip>, [">= 0", "= 1.0.0"])
      s.add_runtime_dependency(%q<haml>, [">= 0", "= 2.0.9"])
      s.add_runtime_dependency(%q<liquid>, [">= 0", "= 2.0.0"])
      s.add_runtime_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
      s.add_runtime_dependency(%q<rack-cache>, [">= 0", "= 0.4"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0", "= 0.9.1.1"])
      s.add_dependency(%q<activerecord>, [">= 0", "= 2.3.2"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0", "= 1.2.1"])
      s.add_dependency(%q<clip>, [">= 0", "= 1.0.0"])
      s.add_dependency(%q<haml>, [">= 0", "= 2.0.9"])
      s.add_dependency(%q<liquid>, [">= 0", "= 2.0.0"])
      s.add_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
      s.add_dependency(%q<rack-cache>, [">= 0", "= 0.4"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0", "= 0.9.1.1"])
    s.add_dependency(%q<activerecord>, [">= 0", "= 2.3.2"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0", "= 1.2.1"])
    s.add_dependency(%q<clip>, [">= 0", "= 1.0.0"])
    s.add_dependency(%q<haml>, [">= 0", "= 2.0.9"])
    s.add_dependency(%q<liquid>, [">= 0", "= 2.0.0"])
    s.add_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
    s.add_dependency(%q<rack-cache>, [">= 0", "= 0.4"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end
