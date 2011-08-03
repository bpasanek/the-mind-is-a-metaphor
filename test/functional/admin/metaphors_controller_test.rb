require 'test_helper'

class Admin::MetaphorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metaphors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metaphor" do
    assert_difference('Metaphor.count') do
      post :create, :metaphor => {:metaphor=>'blah'}
    end
    assert_redirected_to admin_metaphor_path(assigns(:metaphor))
  end
  
  test "should show metaphor" do
    get :show, :id => metaphors(:Metaphor_9681).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => metaphors(:Metaphor_9681).id
    assert_response :success
  end

  test "should update metaphor" do
    put :update, :id => metaphors(:Metaphor_9681).id, :metaphor => { }
    assert_redirected_to admin_metaphor_path(assigns(:metaphor))
  end

  test "should destroy metaphor" do
    assert_difference('Metaphor.count', -1) do
      delete :destroy, :id => metaphors(:Metaphor_9681).id
    end

    assert_redirected_to admin_metaphors_path
  end
end