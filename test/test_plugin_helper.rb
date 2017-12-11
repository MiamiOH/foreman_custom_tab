# populate custom tab settings for test env
# NOTE: this needs to be updated before calling foreman test_helper
SETTINGS[:custom_tab] = { fields: { 'Host Name' => 'name',
                                    'MAC Address' => 'mac',
                                    'IP Address' => 'ip',
                                    'Architecture' => 'arch',
                                    'Certificate Name' => 'certname',
                                    'OS Title' => 'operatingsystem.title',
                                    'OS Type' => 'operatingsystem.type' },
                          title: 'foo' }

# This calls the main test_helper in Foreman-core
require 'test_helper'

class Object
  def get_chained_attr_val(attrs)
    attr_val = nil
    attrs.split('.').each_with_index do |method, index|
      attr_val = index.eql?(0) ? try(method) : attr_val.try(method)
    end
    attr_val
  end
end
