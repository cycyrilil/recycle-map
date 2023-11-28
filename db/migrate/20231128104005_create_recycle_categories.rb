class CreateRecycleCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :recycle_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :recycle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
