class RemoveImageRecordTable < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :summary_translations, :image_records
    drop_table :image_records
  end
end
