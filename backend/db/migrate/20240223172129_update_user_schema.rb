class UpdateUserSchema < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :phone_number, :string
    add_column :users, :verified, :boolean, default: false

    add_index :users, :username, unique: true
    add_index :users, :phone_number, unique: true
  end
end
