require 'test_plugin_helper'

class HostsHelperExtensionsTest < ActiveSupport::TestCase
  include ForemanCustomTab::HostsHelperExtensions

  let(:os) { FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat') }
  let(:arch) { FactoryBot.create(:architecture) }
  # rubocop:disable Layout/LineLength
  let(:host) { FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: arch) }
  # rubocop:enable Layout/LineLength
  let(:expected_fields) do
    fields = []
    SETTINGS[:custom_tab][:fields].each do |title, host_attr|
      fields << [title, host.get_chained_attr_val(host_attr)]
    end
    fields
  end

  describe '#custom_tab_fields(host)' do
    test 'returns fields as expected' do
      assert_equal custom_tab_fields(host), expected_fields
    end
  end

  describe '#custom_tab_title' do
    title_orig = SETTINGS[:custom_tab][:title]
    test 'returns correct title' do
      assert_equal custom_tab_title, title_orig
    end

    test 'settings title is not present' do
      SETTINGS[:custom_tab][:title] = nil
      assert_equal custom_tab_title, 'Custom Tab'
      SETTINGS[:custom_tab][:title] = title_orig
    end
  end
end
