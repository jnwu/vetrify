require 'test_helper'

class BusinessUsersControllerTest < ActionController::TestCase
  setup do
    @business_user = business_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_user" do
    assert_difference('BusinessUser.count') do
      post :create, business_user: { business_id: @business_user.business_id, email: @business_user.email, first_name: @business_user.first_name, last_name: @business_user.last_name, password: @business_user.password, password_digest: @business_user.password_digest, title: @business_user.title }
    end

    assert_redirected_to business_user_path(assigns(:business_user))
  end

  test "should show business_user" do
    get :show, id: @business_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_user
    assert_response :success
  end

  test "should update business_user" do
    patch :update, id: @business_user, business_user: { business_id: @business_user.business_id, email: @business_user.email, first_name: @business_user.first_name, last_name: @business_user.last_name, password: @business_user.password, password_digest: @business_user.password_digest, title: @business_user.title }
    assert_redirected_to business_user_path(assigns(:business_user))
  end

  test "should destroy business_user" do
    assert_difference('BusinessUser.count', -1) do
      delete :destroy, id: @business_user
    end

    assert_redirected_to business_users_path
  end
end
