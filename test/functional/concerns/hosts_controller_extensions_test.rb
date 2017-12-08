require 'test_plugin_helper'

class HostsControllerTest < ActionController::TestCase  
  let(:os){FactoryBot.create(:operatingsystem, name: 'CentOS', major: '7', type: 'Redhat')}
  let(:arch){FactoryBot.create(:architecture)}
  let(:host){FactoryBot.create(:host, id: 'foreman.example.com', mac: '00:00:00:00:00:00', ip: '127.0.0.1', operatingsystem: os, arch: arch)}         
  let(:custom_tab_title){SETTINGS[:custom_tab][:title]}
  test 'GET hosts/:id displays tabs' do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_equal response.status, 200
    assert_includes response.body, "ul id=\"myTab\""
  end

  test "host overview displays tabs 'Properties', 'Metrics', 'NICs'" do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_equal response.status, 200
    assert_includes response.body, "<ul id=\"myTab\""
    assert_includes response.body, "<li class=\"active\"><a href=\"#properties\" data-toggle=\"tab\">Properties</a></li>"
    assert_includes response.body, "<li><a href=\"#metrics\" data-toggle=\"tab\">Metrics</a></li>"
    assert_includes response.body, "<li><a href=\"#nics\" data-toggle=\"tab\">NICs</a></li>"
  end

  test "host overview displays the Custom Tab" do
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_includes response.body, "<ul id=\"myTab\""
    assert_equal response.status, 200
    assert_includes response.body, "<li><a href=\"#custom_tab\" data-toggle=\"tab\">#{custom_tab_title}</a></li>"
  end
end
