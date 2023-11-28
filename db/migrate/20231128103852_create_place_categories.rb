class CreatePlaceCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :place_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
