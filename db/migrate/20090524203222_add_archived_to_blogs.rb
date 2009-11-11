class AddArchivedToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :archived, :boolean, :default => 0
  end

  def self.down
    remove_column :blogs, :archived
  end
end
