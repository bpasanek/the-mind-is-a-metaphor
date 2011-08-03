require 'test_helper'

class Admin::TypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type" do
    assert_difference('Type.count') do
      post :create, :type => {:name=>'test', :metaphor_id=>1}
    end
    assert_redirected_to admin_type_path(assigns(:type))
  end
  
  test "should show type" do
    get :show, :id => types(:metaphor_9681_type).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => types(:metaphor_9681_type).id
    assert_response :success
  end

  test "should update type" do
    put :update, :id => types(:metaphor_9681_type).id, :type => { }
    assert_redirected_to admin_type_path(assigns(:type))
  end

  test "should destroy type" do
    assert_difference('Type.count', -1) do
      delete :destroy, :id => types(:metaphor_9681_type).id
    end

    assert_redirected_to admin_types_path
  end
end