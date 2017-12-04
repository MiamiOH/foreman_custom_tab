require 'test_plugin_helper'

class HostsControllerTest < ActionController::TestCase  
  
  test 'GET hosts/:id displays tabs' do
    host = mock_host
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_includes response.body, "ul id=\"myTab\""
  end

  test "GET host tabs include 'metrics', 'nics'" do
    host = mock_host
    get :show, { :id => host.id }, set_session_user
    assert_includes response.headers['Content-Type'], 'text/html'
    assert_includes response.body, "<ul id=\"myTab\""
    assert_includes response.body, "<li><a href=\"#metrics\" data-toggle=\"tab\">Metrics</a></li>"
    assert_includes response.body, "<li><a href=\"#nics\" data-toggle=\"tab\">NICs</a></li>"
  end
end
