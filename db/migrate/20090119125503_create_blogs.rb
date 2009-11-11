class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string  :title,       :null => false
      t.text    :blurb
      t.integer :project_id,  :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
