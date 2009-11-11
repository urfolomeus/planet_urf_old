class AddCommentsCountToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :comments_count, :integer, :default => 0
    execute "UPDATE blogs SET comments_count = (SELECT COUNT(*) FROM comments WHERE blog_id = blogs.id)"
  end

  def self.down
    remove_column :blogs, :comments_count
  end
end
