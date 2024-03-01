class AddUserToSummaryTranslations < ActiveRecord::Migration[7.1]
  def change
    remove_column :summary_translations, :user_id, :bigint
    add_reference :summary_translations, :user, null: false, foreign_key: true
  end
end
