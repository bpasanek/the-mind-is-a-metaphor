require 'test_helper'

class Admin::OccupationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occupations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occupation" do
    assert_difference('Occupation.count') do
      post :create, :occupation => {:name=>'test'}
    end
    assert_redirected_to admin_occupation_path(assigns(:occupation))
  end

  test "should show occupation" do
    get :show, :id => occupations(:poet).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => occupations(:poet).id
    assert_response :success
  end

  test "should update occupation" do
    put :update, :id => occupations(:poet).id, :occupation => { }
    assert_redirected_to admin_occupation_path(assigns(:occupation))
  end

  test "should destroy occupation" do
    assert_difference('Occupation.count', -1) do
      delete :destroy, :id => occupations(:poet).id
    end

    assert_redirected_to admin_occupations_path
  end
end
