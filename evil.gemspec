# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{evil}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Webb"]
  s.date = %q{2009-04-15}
  s.default_executable = %q{evil}
  s.description = %q{A simple framework for creating sites from 3rd party data and services}
  s.email = %q{dan@danwebb.net}
  s.executables = ["evil"]
  s.extra_rdoc_files = ["bin/evil", "CHANGELOG", "lib/evil/application.rb", "lib/evil/extensions.rb", "lib/evil/helpers.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/open_id.rb", "lib/evil/plugin/base.rb", "lib/evil/plugin/configuration.rb", "lib/evil/plugin/environment.rb", "lib/evil/plugin/filesystem.rb", "lib/evil/plugin/tag.rb", "lib/evil/plugin.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb", "LICENSE", "README.textile"]
  s.files = ["assets/config.ru", "assets/evil-lib.js", "assets/evil.css", "assets/evil.js", "assets/logo.png", "bin/evil", "CHANGELOG", "evil.gemspec", "lib/evil/application.rb", "lib/evil/extensions.rb", "lib/evil/helpers.rb", "lib/evil/models/config_pair.rb", "lib/evil/models/template.rb", "lib/evil/models/whitelist.rb", "lib/evil/models.rb", "lib/evil/open_id.rb", "lib/evil/plugin/base.rb", "lib/evil/plugin/configuration.rb", "lib/evil/plugin/environment.rb", "lib/evil/plugin/filesystem.rb", "lib/evil/plugin/tag.rb", "lib/evil/plugin.rb", "lib/evil/setup/db_tool.rb", "lib/evil/setup/generator.rb", "lib/evil/setup/migration.rb", "lib/evil.rb", "LICENSE", "Manifest", "Rakefile", "README.textile", "test/app/evil_test.rb", "test/dev_env.rb", "test/example/cache/entity/05/19485c8cdaf092dae8b3db6aab4cd04f06cc90", "test/example/cache/entity/15/fb2cf137dc9c8d6d706d7b98225d823756a788", "test/example/cache/entity/52/2bd948a2ac39de3d7ce90ebaf45c325e885c8c", "test/example/cache/entity/7c/e4816a511462f7d0be1145841809c4c2afb8ae", "test/example/cache/entity/96/05e17096a8196debfe51870a9f06920f58893c", "test/example/cache/entity/a2/fd775ebfcd1ee859ebe4b0710d01f1a0335541", "test/example/cache/entity/c4/2b5e6786658efe88c6e050dd5ab760fc3369de", "test/example/cache/entity/cb/2f4cf4adb9896c3416a16110ec9c1e1b07264f", "test/example/cache/entity/ce/8d7505172ce26d41328a32edf1bc589abcf039", "test/example/cache/entity/d9/8ecfcda191d927964a301be9619b95cc07f466", "test/example/cache/entity/eb/cf0101136307b2723fe6c2550603ee8b049aab", "test/example/cache/meta/04/752bffd76d4234e7d4c21ec0e58d50c993b902", "test/example/cache/meta/14/6dc0297f0655e9d9cc338841388825712ffa47", "test/example/cache/meta/62/65b6685da551bb9122e11d03e44a81f3218640", "test/example/cache/meta/7b/5f5a6fdc4def2c1e6216ea99517cee486f56f9", "test/example/cache/meta/91/7a6e48776b3a6a65b77c822596cd1344b6c205", "test/example/cache/meta/9c/c8d024fa300b450426c321f92d0b1cbe7ea32b", "test/example/cache/meta/a3/e2e8cd66ecbeadd342c12c470194053ff91e49", "test/example/cache/meta/b4/04516952f0dc656e8b7744f844f9909dad650a", "test/example/cache/meta/d9/236e8b25e9332f12f31a96060a78b656aaf193", "test/example/config.ru", "test/example/evil.db", "test/example/plugins/test.evil", "test/example/plugins/test2.evil", "test/example/public/images/logo.png", "test/example/public/javascripts/evil-lib.js", "test/example/public/javascripts/evil.js", "test/example/public/stylesheets/evil.css", "test/test_helper.rb", "test/units/plugin/base_test.rb", "test/units/plugin/tag_test.rb", "views/_banner.haml", "views/_errors.haml", "views/index.haml", "views/layout.haml", "views/login.haml", "views/plugins/_fields.haml", "views/plugins/edit.haml", "views/plugins/fields/_password.haml", "views/plugins/fields/_text.haml", "views/plugins/new.haml", "views/templates/_fields.haml", "views/templates/edit.haml", "views/templates/new.haml"]
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
      s.add_runtime_dependency(%q<haml>, [">= 0", "= 2.0.0"])
      s.add_runtime_dependency(%q<liquid>, [">= 0", "= 1.9.0"])
      s.add_runtime_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0", "= 0.9.1.1"])
      s.add_dependency(%q<activerecord>, [">= 0", "= 2.3.2"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0", "= 1.2.1"])
      s.add_dependency(%q<clip>, [">= 0", "= 1.0.0"])
      s.add_dependency(%q<haml>, [">= 0", "= 2.0.0"])
      s.add_dependency(%q<liquid>, [">= 0", "= 1.9.0"])
      s.add_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0", "= 0.9.1.1"])
    s.add_dependency(%q<activerecord>, [">= 0", "= 2.3.2"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0", "= 1.2.1"])
    s.add_dependency(%q<clip>, [">= 0", "= 1.0.0"])
    s.add_dependency(%q<haml>, [">= 0", "= 2.0.0"])
    s.add_dependency(%q<liquid>, [">= 0", "= 1.9.0"])
    s.add_dependency(%q<danwrong-liquid-inheritance>, [">= 0", "= 0.1.1"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end
