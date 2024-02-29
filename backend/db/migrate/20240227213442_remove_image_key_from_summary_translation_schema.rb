class RemoveImageKeyFromSummaryTranslationSchema < ActiveRecord::Migration[7.1]
  def change
    remove_column :summary_translations, :image_key, :string
  end
end
