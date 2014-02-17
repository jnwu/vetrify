require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should route omniauth callback" do
    get 'new'
    assert_redirected_to '/auth/linkedin'

    assert_routing'/auth/linkedin/callback', controller: 'sessions', action: 'linkedin'
    assert_redirected_to '/auth/linkedin'
    assert_routing'/auth/github/callback', controller: 'sessions', action: 'github'
    assert_redirected_to '/auth/linkedin'
  end

  test "should handle empty omniauth callback object" do
    get 'linkedin'
    assert_redirected_to controller: 'pages', action: 'landing'

    get 'github'
    assert_redirected_to controller: 'pages', action: 'landing'
  end
end
