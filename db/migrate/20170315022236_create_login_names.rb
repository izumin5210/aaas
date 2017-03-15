class CreateLoginNames < ActiveRecord::Migration[5.0]
  def change
    create_table :login_names, id: :string do |t|
    end
  end
end
