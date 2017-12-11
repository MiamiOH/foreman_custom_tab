module ForemanCustomTab
  module HostsHelperExtensions
    extend ActiveSupport::Concern

    def custom_tab_fields(host)
      fields = []
      config_fields = SETTINGS[:custom_tab][:fields] || []
      config_fields.each do |key, value|
        host_attr_val = nil
        # chain the method calls for attibutes like operatingsystem.title
        value.split('.').each_with_index do |method, index|
          host_attr_val = index.eql?(0) ? host.try(method) : host_attr_val.try(method)
        end
        fields += [[_(key.to_s), host_attr_val]] if host_attr_val.present?
      end
      fields
    end

    def custom_tab_title
      SETTINGS[:custom_tab][:title] || 'Custom Tab'
    end
  end
end
