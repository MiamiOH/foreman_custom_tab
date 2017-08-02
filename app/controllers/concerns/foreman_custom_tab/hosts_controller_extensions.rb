module ForemanCustomTab
  # Example: Plugin's HostsController inherits from Foreman's HostsController
  module HostsControllerExtensions
    extend ActiveSupport::Concern

    def summary
      # We can't add a before_filter :find_resource for Cockpit actions as
      # it'll override the default find_resource filter.
      find_resource
      render :partial => 'foreman_custom_tab/hosts/summary', :locals => { :host => @host }
    rescue ActionView::Template::Error => exception
      process_ajax_error exception, 'fetch summary information'
    end
    
    private
    
    def action_permission
      case params[:action]
      when 'summary'
        :view
      else
        super
      end
    end
  end
end
