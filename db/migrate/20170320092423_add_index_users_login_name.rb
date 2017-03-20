class AddIndexUsersLoginName < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :login_name, unique: true
  end
end
