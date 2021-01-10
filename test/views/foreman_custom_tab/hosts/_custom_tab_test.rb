require 'test_plugin_helper'

class CustomTabTest < ActionView::TestCase
  let(:os) { FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat') }
  let(:arch) { FactoryBot.create(:architecture) }
  # rubocop:disable Layout/LineLength
  let(:host) { FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: arch) }
  # rubocop:enable Layout/LineLength
  let(:custom_tab_title) { SETTINGS[:custom_tab][:title] }

  class FakeHostsController < ApplicationController
    include ForemanCustomTab::HostsHelperExtensions
    include LayoutHelper

    def index
      os = FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat')
      # rubocop:disable Layout/LineLength
      @host = FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: FactoryBot.create(:architecture))
      # rubocop:enable Layout/LineLength
      render :partial => 'foreman_custom_tab/hosts/custom_tab', :locals => { :host => @host }
    end
  end

  test 'successfully render custom_tab partial' do
    skip("NoMethodError: undefined method 'content_type' for nil:NilClass")
    get FakeHostsController.new.index

    assert_select 'custom_table'
  end
end
