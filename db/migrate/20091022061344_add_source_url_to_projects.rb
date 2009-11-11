class AddSourceUrlToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :source_url, :string
  end

  def self.down
    remove_column :projects, :source_url
  end
end
