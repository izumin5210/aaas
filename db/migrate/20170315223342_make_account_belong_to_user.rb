class MakeAccountBelongToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :user_id, :integer, null: false
    add_index :accounts, :user_id, unique: true
    add_foreign_key :accounts, :users, column: :user_id
  end
end
