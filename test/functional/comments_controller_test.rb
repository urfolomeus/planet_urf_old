require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  fixtures :comments
  fixtures :blogs
  fixtures :users
  
  test "should be prompted to login when getting index if not logged in" do
    get :index
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should see list of comments if logged in" do
    get :index, {}, { :user_id => users(:alan).id }
    assert_response :success
    assert_template 'index'
  end
  
  test "should not create comment if not logged in" do
    assert_no_difference('Comment.count') do
      create_comment
    end
    assert_nil assigns(:comment)
    assert_redirected_to :controller => 'session', :action => 'new'
  end

  test "should create comment if logged in" do
    assert_difference('Comment.count') do
      create_comment( { :user_id => users(:alan).id } )
    end
    assert_not_nil assigns(:comment)
    assert_redirected_to blog_path(assigns(:comment).blog_id)
  end
  
  protected

  def create_comment(login = {}, options = {})
    post :create,  {:blog_id => blogs(:first).id,
                    :comment => { :comment  => "New comment",
                                  :blog_id  => blogs(:first).id,
                                  :user_id  => users(:alan).id }.merge(options)
                    }, login
  end
end
