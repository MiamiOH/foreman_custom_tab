require File.expand_path('lib/foreman_custom_tab/version', __dir__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_custom_tab'
  s.version     = ForemanCustomTab::VERSION
  s.date        = Date.today.to_s # rubocop:disable Rails/Date
  s.license     = 'GPL-3.0'
  s.authors     = ['Joe Stannard']
  s.email       = ['stannajl@miamioh.edu']
  s.homepage    = 'https://github.com/MiamiOH/foreman_custom_tab'
  s.summary     = 'Creates custom tab for hosts in Foreman'
  # also update locale/gemspec.rb
  s.description = 'Foreman Plugin that makes a new tab with different fields depending on the settings file'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface', '< 2.0'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rails'
  s.required_ruby_version = '>= 2.5.0'
end
