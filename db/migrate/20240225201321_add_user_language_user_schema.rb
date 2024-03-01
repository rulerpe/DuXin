class AddUserLanguageUserSchema < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :language, :string, default: 'Chinese'
    remove_index :users, :username
  end
end
