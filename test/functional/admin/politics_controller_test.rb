require 'test_helper'

class Admin::PoliticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:politics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create politic" do
    assert_difference('Politic.count') do
      post :create, :politic => {:name=>'test'}
    end

    assert_redirected_to admin_politic_path(assigns(:politic))
  end

  test "should show politic" do
    get :show, :id => politics(:parliamentarian).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => politics(:parliamentarian).id
    assert_response :success
  end

  test "should update politic" do
    put :update, :id => politics(:parliamentarian).id, :politic => { }
    assert_redirected_to admin_politic_path(assigns(:politic))
  end

  test "should destroy politic" do
    assert_difference('Politic.count', -1) do
      delete :destroy, :id => politics(:parliamentarian).id
    end
    assert_redirected_to admin_politics_path
  end
end