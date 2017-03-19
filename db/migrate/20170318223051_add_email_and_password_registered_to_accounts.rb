class AddEmailAndPasswordRegisteredToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :email_and_password_registered, :boolean, null: false, default: false
  end
end
