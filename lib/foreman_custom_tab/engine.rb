require 'deface'
require 'foreman_custom_tab'

module ForemanCustomTab
  class Engine < ::Rails::Engine
    engine_name 'foreman_custom_tab'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]
  
    
    #initializer 'foreman_custom_tab.configure_assets', :group => :assets do
      #SETTINGS[:foreman_custom_tab] = { assets: { precompile: assets_to_precompile } }
    #end
    
    initializer('foreman_custom_tab.register_plugin', :before => :finisher_hook) do
      Foreman::Plugin.register :foreman_custom_tab do
        requires_foreman '>= 1.7'
        
        security_block :foreman_custom_tab do
          permission :view_hosts,
              { :hosts => [:custom_tab] },
              :resource_type => 'Host'
        end
        
        
        
      end
    end
    
    
    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        HostsHelper.send(:include, ForemanCustomTab::HostsHelperExtensions)
        ::HostsController.send(:include,
                               ForemanCustomTab::HostsControllerExtensions)
      rescue => e
        Rails.logger.warn "ForemanCustomTab: skipping engine hook (#{e})"
      end
    end

    initializer 'foreman_custom_tab.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_custom_tab'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
