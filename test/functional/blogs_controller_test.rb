require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  fixtures :projects
  fixtures :blogs

  test "should display list of blogs" do
    get :index
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

  test "should not create blog if not logged in" do
    assert_no_difference('Blog.count') do
      create_blog
    end
    assert_nil assigns(:blog)
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should create blog if logged in" do
    assert_difference('Blog.count') do
      create_blog( { :user_id => users(:alan).id } )
    end
    assert_not_nil assigns(:blog)
    assert_redirected_to blog_path(assigns(:blog))
  end
  
  test "should show blog" do
    get :show, { :id => blogs(:first).id }
    assert_response :success
    assert_template 'show'
  end
  
  test "should be prompted to log in if get edit when not logged in" do
    get :edit, :id => blogs(:first).id
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should get edit if logged in" do
    get :edit, { :id => blogs(:first).id }, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'edit'
  end
  
  test "should not update blog if not logged in" do
    update_blog
    assert_nil assigns(:blog)
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should update blog if logged in" do
    assert_no_difference('Blog.count') do
      update_blog({ :user_id => users(:alan).id })
    end
    assert_not_nil assigns(:blog)
    assert_redirected_to blog_path(assigns(:blog))
  end
  
  test "should not destroy blog if not logged in" do
    assert_no_difference('Blog.count') do
      delete_blog
    end
    assert_redirected_to :controller => 'session', :action => 'new'
  end
  
  test "should destroy blog if logged in" do
    assert_difference('Blog.count', -1) do
      delete_blog( { :user_id => users(:alan).id } )
    end
    assert_redirected_to blogs_path
  end
  
  protected
  
  def create_blog(login = {}, options = {})
    post :create,  {:blog => {:title      => "New blog",
                              :blurb      => "<p>This is a new blog</p>",
                              :project_id => projects(:planet_urf).id }.merge(options)
                    }, login
  end
  
  def update_blog(login = {}, options = {})
    put :update, {:id => blogs(:first).id, 
                  :blog => { :title  => blogs(:first).title + ' edited',
                             :blurb  => blogs(:first).blurb,
                             :project_id => projects(:planet_urf).id }.merge(options) 
                  }, login
  end
  
  def delete_blog(login = {}, options = {})
    delete :destroy, { :id => blogs(:first).id }.merge(options), login
  end
end
