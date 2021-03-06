require 'deface'
require 'foreman_custom_tab'

module ForemanCustomTab
  class Engine < ::Rails::Engine
    engine_name 'foreman_custom_tab'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # requires_foreman version as per
    # http://projects.theforeman.org/projects/foreman/wiki/How_to_Create_a_Plugin#Requiring-Foreman-version

    # Adding permission to controller action
    # http://projects.theforeman.org/projects/foreman/wiki/How_to_Create_a_Plugin#Adding-permission
    initializer('foreman_custom_tab.register_plugin', :before => :finisher_hook) do
      Foreman::Plugin.register :foreman_custom_tab do
        requires_foreman '>= 2.3'

        security_block :foreman_custom_tab do
          permission :view_custom_tab,
                     { :hosts => [:custom_tab] },
                     :resource_type => 'Host'
        end
      end
    end

    # Extending a controller
    # Include concerns in this config.to_prepare block
    # http://projects.theforeman.org/projects/foreman/wiki/How_to_Create_a_Plugin#Extending-a-Controller
    config.to_prepare do
      HostsHelper.include ForemanCustomTab::HostsHelperExtensions
      ::HostsController.include ForemanCustomTab::HostsControllerExtensions
    rescue StandardError => e
      Rails.logger.warn "ForemanCustomTab: skipping engine hook (#{e})"
    end

    initializer 'foreman_custom_tab.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../..', __dir__), 'locale')
      locale_domain = 'foreman_custom_tab'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
