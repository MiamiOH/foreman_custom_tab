require 'test_plugin_helper'

class HostsControllerTest < ActionController::TestCase
  let(:os) { FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat') }
  let(:arch) { FactoryBot.create(:architecture) }
  let(:host_id) { 'foreman.example.com' }
  # rubocop:disable Layout/LineLength
  let(:host) { FactoryBot.create(:host, id: host_id, mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: arch) }
  # rubocop:enable Layout/LineLength
  let(:custom_tab_title) { SETTINGS[:custom_tab][:title] }

  # rubocop:disable Layout/LineLength, Style/StringLiterals, Rails/HttpPositionalArguments
  test 'GET hosts/:id displays tabs' do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_equal response.status, 200
    assert_includes response.body, "ul id=\"host-show-tabs\""
  end

  test "host overview displays tabs 'Properties', 'Metrics', 'NICs'" do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_equal response.status, 200
    assert_includes response.body, "<ul id=\"host-show-tabs\""
    assert_includes response.body, "<li class=\"active\"><a href=\"#properties\" data-toggle=\"tab\">Properties</a></li>"
    assert_includes response.body, "<li><a href=\"#metrics\" data-toggle=\"tab\">Metrics</a></li>"
    assert_includes response.body, "<li><a href=\"#nics\" data-toggle=\"tab\">NICs</a></li>"
  end

  test "host overview displays the Custom Tab" do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_includes response.body, "<ul id=\"host-show-tabs\""
    assert_equal response.status, 200
    assert_includes response.body, "<li><a href=\"#custom_tab\" data-toggle=\"tab\">#{custom_tab_title}</a></li>"
  end

  test "host/:id contains custom_tab ajax link" do
    get :show, { :id => host.id }, set_session_user

    assert_equal response.status, 200
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_includes response.body, "<ul id=\"host-show-tabs\""
    assert_includes response.body, "<li><a href=\"#custom_tab\" data-toggle=\"tab\">#{custom_tab_title}</a></li>"
    assert_includes response.body, "<div id=\"custom_tab\" class=\"tab-pane\" data-ajax-url=\"/hosts/#{host.name}/custom_tab\" data-on-complete=\"onContentLoad\">"
  end

  describe 'When hosts#show' do
    before do
      host_id = 'foreman.example.com'
      Rails.application.routes.draw do
        get "/hosts/#{host_id}/custom_tab" => 'hosts_controller#custom_tab'
      end
    end
    after do
      Rails.application.reload_routes!
    end

    test 'AJAX request hosts/:id/custom_tab displays custom host data' do
      skip("xhr route missing: ActionController::UrlGenerationError:
            No route matches {:action=>'/hosts/host6/custom_tab', :controller=>'hosts'}")
      # get "/hosts/#{host.name}/custom_tab", xhr: true
      # xhr :get, custom_tab_host_path(host), delivery_method: :deliver, status: :pending, format: 'js'
      get custom_tab_host_path(host), params: { xhr: true }
      # get "/hosts/#{host_id}/custom_tab"

      SETTINGS[:custom_tab][:fields].each do |title, attr|
        assert_includes response.body, "<td>#{title}</td>"
        assert_includes response.body, "<td>#{host.get_chained_attr_val(attr)}</td>"
      end
    end
  end
  # rubocop:enable Layout/LineLength, Style/StringLiterals, Rails/HttpPositionalArguments
end
