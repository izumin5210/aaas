class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :login_name, null: false

      t.timestamps
    end
    add_index :organizations, :login_name, unique: true
    add_foreign_key :organizations, :login_names, column: :login_name
  end
end
