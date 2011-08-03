require 'test_helper'

class Admin::WorksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post :create, :work => {:title=>'test'}
    end
    assert_redirected_to admin_work_path(assigns(:work))
  end
  
  test 'should correctly route works of author (nested route)' do
    # note: to_s seems requried
    aid = authors(:first).id.to_s
    expected_options = {:controller => 'admin/works', :action => 'index', :author_id => aid}
    assert_routing("/admin/authors/#{aid}/works", expected_options)
  end
  
  test "should create work and author_work" do
    author = authors(:first)
    assert_difference('AuthorWork.count') do
      post :create, :author_id=>author.id.to_s, :work => {:title=>'test', :author_works_attributes => [{:author_id=>author.id}]}
    end
    assert_redirected_to admin_author_work_path(author, assigns(:work))
  end
  
  test "should show work" do
    get :show, :id => works(:Work_3752).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => works(:Work_3752).id
    assert_response :success
  end
  
  test "should update work" do
    put :update, :id => works(:Work_3752).id, :work => { }
    assert_redirected_to admin_work_path(assigns(:work))
  end
  
  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete :destroy, :id => works(:Work_3752).id
    end

    assert_redirected_to admin_works_path
  end
end
