require 'test_helper'

class Admin::ReligionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:religions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create religion" do
    assert_difference('Religion.count') do
      post :create, :religion => {:name=>'test'}
    end
    assert_redirected_to admin_religion_path(assigns(:religion))
  end

  test "should show religion" do
    get :show, :id => religions(:protestant).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => religions(:protestant).id
    assert_response :success
  end

  test "should update religion" do
    put :update, :id => religions(:protestant).id, :religion => { }
    assert_redirected_to admin_religion_path(assigns(:religion))
  end
  
  test "should destroy religion" do
    assert_difference('Religion.count', -1) do
      delete :destroy, :id => religions(:protestant).id
    end
    assert_redirected_to admin_religions_path
  end
end
