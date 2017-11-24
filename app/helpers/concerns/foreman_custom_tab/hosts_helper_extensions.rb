module ForemanCustomTab
  module HostsHelperExtensions
    extend ActiveSupport::Concern
    
    def custom_tab_fields(host)      
      fields = []
      rows = SETTINGS[:custom_tab][:fields] || []
      rows.each do |name, value|
        result = nil
        name = name.parameterize.underscore
        result = host.try(name) 
        fields += [[_(name.to_s), result]] if result.present?
      end
      fields
    end
    
  end
end
