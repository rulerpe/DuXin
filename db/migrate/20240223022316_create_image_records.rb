class CreateImageRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :image_records do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image_key
      t.text :extracted_text

      t.timestamps
    end
  end
end
