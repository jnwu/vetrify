require 'test_helper'

class SessionsControllerTest < ActionController::TestCase




  test "should sign in business user" do
    @user = FactoryGirl.create(:business_user)
    post :create, user_type: "business_user", email: @user.email, password: @user.password

    assert_equal @user.id, session[:user_id]
  end

  test "should sign in normal user" do
    @user = FactoryGirl.create(:profile)
    post :create, user_type: "applicant", email: @user.email, password: @user.password

    assert_equal @user.id, session[:user_id]
  end


  test "should logout user" do
    post :destroy

    assert_equal nil, session[:user_id]
  end


end
