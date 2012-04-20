require 'test_helper'

class Backend::CommentsControllerTest < ActionController::TestCase
  setup do
    @backend_comment = backend_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:backend_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create backend_comment" do
    assert_difference('Backend::Comment.count') do
      post :create, backend_comment: @backend_comment.attributes
    end

    assert_redirected_to backend_comment_path(assigns(:backend_comment))
  end

  test "should show backend_comment" do
    get :show, id: @backend_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @backend_comment.to_param
    assert_response :success
  end

  test "should update backend_comment" do
    put :update, id: @backend_comment.to_param, backend_comment: @backend_comment.attributes
    assert_redirected_to backend_comment_path(assigns(:backend_comment))
  end

  test "should destroy backend_comment" do
    assert_difference('Backend::Comment.count', -1) do
      delete :destroy, id: @backend_comment.to_param
    end

    assert_redirected_to backend_comments_path
  end
end
