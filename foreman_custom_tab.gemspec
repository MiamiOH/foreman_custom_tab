require File.expand_path('../lib/foreman_custom_tab/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'foreman_custom_tab'
  s.version     = ForemanCustomTab::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Joe Stannard']
  s.email       = ['stannajl@miamioh.edu']
  s.homepage    = 'https://github.com/rougehero/foreman_custom_tab'
  s.summary     = 'creates custom tab for hosts'
  # also update locale/gemspec.rb
  s.description = 'Makes a new tab that has different fields depending on the settings file'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
