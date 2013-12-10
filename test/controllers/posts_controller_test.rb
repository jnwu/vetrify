require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = FactoryGirl.create(:post)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    #assert_difference('Post.count') do
    #  post :create, post: { company_id: @post.company_id, desired_skills: @post.desired_skills, expected_skills: @post.expected_skills, expire_at: @post.expire_at, position: @post.position, start_at: @post.start_at, summary: @post.summary }
    #end
    #
    #assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: FactoryGirl.attributes_for(:post)
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
