require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  fixtures :projects
  fixtures :blogs
  
  test "valid with valid data" do
    blog = Blog.new(:title => blogs(:first).title,
                    :blurb => blogs(:first).blurb,
                    :project_id => projects(:planet_urf).id)
    assert blog.valid?
  end
  
  test "invalid with empty attributes" do
    blog = Blog.new
    assert !blog.valid?
    assert blog.errors.invalid?(:title)
    assert blog.errors.invalid?(:blurb)
    assert blog.errors.invalid?(:project_id)
  end
  
  test "invalid with non-existant project" do
    blog = Blog.new(:title => blogs(:first).title,
                    :blurb => blogs(:first).blurb,
                    :project_id => "INVALID")
    assert !blog.valid?
    assert blog.errors.invalid?(:project_id)
  end
end
