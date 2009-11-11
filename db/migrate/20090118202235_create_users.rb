class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string    :login
      t.string    :email
      t.string    :first_name,                :limit => 80
      t.string    :last_name,                 :limit => 80
      t.boolean   :is_admin,                  :default => false
      t.string    :crypted_password,          :limit => 40
      t.string    :salt,                      :limit => 40
      t.string    :remember_token
      t.datetime  :remember_token_expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
