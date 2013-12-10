require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  setup do
    @business = businesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business" do
    #assert_difference('business.count') do
    #  post :create, business: { name: @business.name, business_type: @business.business_type, founded_year: @business.founded_year, status: @business.status, location: @business.location, size: @business.size, specialties: @business.specialties, domain: @business.domain, url: @business.url, linkedin: @business.linkedin }
    #end
    #
    #assert_redirected_to business_path(assigns(:business))
  end

  test "should show business" do
    get :show, id: @business
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business
    assert_response :success
  end

  test "should update business" do
    patch :update, id: @business, business: { name: @business.name }
    assert_redirected_to business_path(assigns(:business))
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete :destroy, id: @business
    end

    assert_redirected_to businesses_path
  end
end
