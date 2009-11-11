require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  fixtures :projects
  fixtures :users

  test "should be prompted to login when getting index if not logged in" do
    get :index
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should see list of projects if logged in" do
    get :index, {}, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'index'
  end

  test "should be prompted to login when getting new if not logged in" do
    get :new
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should get new if logged in" do
    get :new, {}, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'new'
  end

  test "should not create project if not logged in" do
    assert_no_difference('Project.count') do
      create_project
    end
    assert_nil assigns(:project)
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should create project if logged in" do
    assert_difference('Project.count') do
      create_project( { :user_id => users(:alan).id } )
    end
    assert_not_nil assigns(:project)
    assert_redirected_to project_path(assigns(:project))
  end
  
  test "should not show project if not logged in" do
    get :show, :id => projects(:planet_urf).id
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should show project if logged in" do
    get :show, { :id => projects(:planet_urf).id }, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'show'
  end
  
  test "should be prompted to log in if get edit when not logged in" do
    get :edit, :id => projects(:planet_urf).id
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should get edit if logged in" do
    get :edit, { :id => projects(:planet_urf).id }, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'edit'
  end
  
  test "should not update project if not logged in" do
    update_project
    assert_nil assigns(:project)
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should update project if logged in" do
    assert_no_difference('Project.count') do
      update_project({ :user_id => users(:alan).id })
    end
    assert_not_nil assigns(:project)
    assert_redirected_to project_path(assigns(:project))
  end
  
  test "should not destroy project if not logged in" do
    assert_no_difference('Project.count') do
      delete_project
    end
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should destroy project if logged in" do
    assert_difference('Project.count', -1) do
      delete_project( { :user_id => users(:alan).id } )
    end
    assert_redirected_to projects_path
  end
  
  protected

  def create_project(login = {}, options = {})
    post :create,  {:project => {:title  => "New project",
                                  :blurb  => "<p>This is a new project</p>",
                                  :url    => "http://www.example.com" }.merge(options)
                    }, login
  end
  
  def update_project(login = {}, options = {})
    put :update, {:id => projects(:planet_urf).id, 
                  :project => { :title  => projects(:planet_urf).title,
                                :blurb  => projects(:planet_urf).blurb,
                                :url    => projects(:planet_urf).url }.merge(options) 
                  }, login
  end
  
  def delete_project(login = {}, options = {})
    delete :destroy, { :id => projects(:honours).id }.merge(options), login
  end
end