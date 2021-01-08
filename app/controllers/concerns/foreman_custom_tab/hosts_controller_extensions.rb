module ForemanCustomTab
  # Example: Plugin's HostsController inherits from Foreman's HostsController
  module HostsControllerExtensions
    extend ActiveSupport::Concern

    def custom_tab
      # We can't add a before_filter :find_resource for Cockpit actions as
      # it'll override the default find_resource filter.
      find_resource
      render :partial => 'foreman_custom_tab/hosts/custom_tab', :locals => { :host => @host }
    rescue ActionView::Template::Error => e
      process_ajax_error e, 'fetch custom tab information'
    end

    private

    def action_permission
      case params[:action]
      when 'custom_tab'
        :view
      else
        super
      end
    end
  end
end
