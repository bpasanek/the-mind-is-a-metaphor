require 'test_helper'

class Admin::NationalitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nationalities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nationality" do
    assert_difference('Nationality.count') do
      post :create, :nationality => {:name=>'test'}
    end
    assert_redirected_to admin_nationality_path(assigns(:nationality))
  end

  test "should show nationality" do
    get :show, :id => nationalities(:american).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nationalities(:american).id
    assert_response :success
  end

  test "should update nationality" do
    put :update, :id => nationalities(:american).id, :nationality => { }
    assert_redirected_to admin_nationality_path(assigns(:nationality))
  end

  test "should destroy nationality" do
    assert_difference('Nationality.count', -1) do
      delete :destroy, :id => nationalities(:american).id
    end

    assert_redirected_to admin_nationalities_path
  end
end