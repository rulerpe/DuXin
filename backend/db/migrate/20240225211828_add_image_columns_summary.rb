class AddImageColumnsSummary < ActiveRecord::Migration[7.1]
  def change
    add_column :summary_translations, :image_key, :string
    add_column :summary_translations, :extracted_text, :text
  end
end
