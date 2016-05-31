require 'test_helper'

class OrganizesControllerTest < ActionController::TestCase
  setup do
    @organize = organizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organize" do
    assert_difference('Organize.count') do
      post :create, organize: {  }
    end

    assert_redirected_to organize_path(assigns(:organize))
  end

  test "should show organize" do
    get :show, id: @organize
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organize
    assert_response :success
  end

  test "should update organize" do
    patch :update, id: @organize, organize: {  }
    assert_redirected_to organize_path(assigns(:organize))
  end

  test "should destroy organize" do
    assert_difference('Organize.count', -1) do
      delete :destroy, id: @organize
    end

    assert_redirected_to organizes_path
  end
end
