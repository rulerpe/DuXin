class UpdateLanguageDefaultValue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :language, 'zh'
  end
end
