# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091022061344) do

  create_table "blogs", :force => true do |t|
    t.string   "title",                             :null => false
    t.text     "blurb"
    t.integer  "project_id",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
    t.boolean  "archived",       :default => false
  end

  create_table "comments", :force => true do |t|
    t.text     "comment",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "blog_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "project_id", :null => false
    t.string   "category"
    t.string   "status"
    t.integer  "revision"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "source_url"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "first_name",                :limit => 80
    t.string   "last_name",                 :limit => 80
    t.boolean  "is_admin",                                :default => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
