# This calls the main test_helper in Foreman-core
require 'test_helper'

HOST_STRING_ATTRS = {name: 'foreman_custom_tab', mac: '00:00:00:00:00:00', ip: '127.0.0.1', certname: 'host.test.com'}
            
def mock_host
    host = FactoryBot.create(:host)
    HOST_STRING_ATTRS.each do |_attr, _val|
        host.send("#{_attr}=", _val)
    end
    # architecture
    arch = FactoryBot.create(:architecture)
    host.arch = arch
    # operatingsystem
    os = FactoryBot.create(:operatingsystem)
    os.name = 'CentOS 7'
    os.major = 'CentOS'
    os.minor = '7'
    os.type = 'RHEL'
    host.operatingsystem = os
    host
end