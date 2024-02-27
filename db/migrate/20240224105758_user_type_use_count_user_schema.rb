class UserTypeUseCountUserSchema < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_type, :string, default: 'USER'
    add_column :users, :document_count, :integer, default: 0
  end
end
