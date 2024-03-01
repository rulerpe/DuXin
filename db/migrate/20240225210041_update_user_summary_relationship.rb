class UpdateUserSummaryRelationship < ActiveRecord::Migration[7.1]
  def change
    rename_column :summary_translations, :image_record_id, :user_id
  end
end
