class Comment < ActiveRecord::Base
  belongs_to :blog, :counter_cache => true
  belongs_to :user
  
  validates_presence_of :comment
  validate :user_exists, :blog_exists
  
  private
  
  def user_exists
    if !User.exists?(user_id)
      errors.add(:user_id, "doesn't exist")
    end
  end
  
  def blog_exists
    if !Blog.exists?(blog_id)
      errors.add(:blog_id, "doesn't exist")
    end
  end
end
