require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :comments
  fixtures :blogs
  fixtures :users

  test "valid with valid data" do
    comment = Comment.new(:comment => comments(:agree).comment,
                          :blog_id => blogs(:first).id,
                          :user_id => users(:alan).id)
    assert comment.valid?
  end

  test "invalid with empty attributes" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:comment)
    assert comment.errors.invalid?(:blog_id)
    assert comment.errors.invalid?(:user_id)
  end

  test "invalid with non-existant blog" do
    comment = Comment.new(:comment => comments(:agree).comment,
                          :blog_id => "INVALID",
                          :user_id => users(:alan).id)
    assert !comment.valid?
    assert comment.errors.invalid?(:blog_id)
  end

  test "invalid with non-existant user" do
    comment = Comment.new(:comment => comments(:agree).comment,
                          :blog_id => blogs(:first).id,
                          :user_id => "INVALID")
    assert !comment.valid?
    assert comment.errors.invalid?(:user_id)
  end
end
