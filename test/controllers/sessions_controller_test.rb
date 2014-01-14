require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should sign in business user" do
    @user = FactoryGirl.create(:business_user)
    post :create, user_type: "business_user", email: @user.email, password: @user.password
  
    assert_equal @user.id, session[:user_id]
    assert_equal "business_user", session[:user_type]
  end

  test "should sign in applicant" do
    @user = FactoryGirl.create(:applicant)
    post :create, user_type: "applicant", email: @user.email, password: @user.password
  
    assert_equal @user.id, session[:user_id]
    assert_equal "applicant", session[:user_type]
  end

  test "should not sign in with incorrect password" do
    @user = FactoryGirl.create(:profile)
    post :create, user_type: "applicant", email: @user.email, password: "blank"

    assert_equal nil, session[:user_id]
  end

  test "should logout user" do
    post :destroy
    assert_equal nil, session[:user_id]
  end
end
