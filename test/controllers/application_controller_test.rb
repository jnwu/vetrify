require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "current_user should return a signed in user" do
    @user = FactoryGirl.create(:profile)

    session[:user_type] = "applicant"
    session[:user_id]   = @user.id

    assert_equal current_user, @user
  end

end
