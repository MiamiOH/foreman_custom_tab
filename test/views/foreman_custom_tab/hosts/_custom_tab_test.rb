require 'test_plugin_helper'

class CustomTabTest < ActionView::TestCase
  let(:os){FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat')}
  let(:arch){FactoryBot.create(:architecture)}
  let(:host){FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: arch)}         
  let(:custom_tab_title){SETTINGS[:custom_tab][:title]}  
  
  class FakeHostsController < ActionController::Base
    include ForemanCustomTab::HostsHelperExtensions
    include LayoutHelper

    def index
      os = FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat')
      @host = FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: FactoryBot.create(:architecture))
      
      render :partial => 'foreman_custom_tab/hosts/custom_tab', :locals => { :host => @host }      
    end
  end

  test 'successfully render custom_tab partial' do
    skip()
    get FakeHostsController.new.index
    
    assert_select 'custom_table'
  end
end
