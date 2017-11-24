module ForemanCustomTab
  module HostsHelperExtensions
    extend ActiveSupport::Concern
    
    def custom_tab_fields(host)
      fields = []
      rows = SETTINGS[:custom_tab][:fields] || []
      rows.each do |name, value|
        result = nil
        value.split('.').each_with_index do |method, index|
          result = index.eql?(0) ? host.try(method) : result.try(method)
        end
        fields += [[_(name.to_s), result]] if result.present?
      end
      fields
    end
    
  end
end
