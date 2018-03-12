module ForemanCustomTab
  module HostsHelperExtensions
    extend ActiveSupport::Concern

    def custom_tab_fields(host)
      fields = []
      config_fields = SETTINGS[:custom_tab][:fields] || []
      config_fields.each do |key, value|
        # chain the method calls for attibutes like operatingsystem.title
        host_attr_val = value.split('.').inject(host) do |memo, method|
          if (m = method.match(/(.*)\((.*)\)/))
            memo.try(m[1], *m[2].split(/,\s?/))
          elsif (m = method.match(/(.*)\[(.*)\]/))
            memo.try(m[1]).try('[]', m[2])
          else
            memo.try(method)
          end
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
