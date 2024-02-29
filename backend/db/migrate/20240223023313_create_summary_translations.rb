class CreateSummaryTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :summary_translations do |t|
      t.references :image_record, null: false, foreign_key: true
      t.string :original_title
      t.string :translated_title
      t.text :original_body
      t.text :translated_body
      t.text :original_action
      t.text :translated_action
      t.string :original_language
      t.string :translation_language

      t.timestamps
    end
  end
end
