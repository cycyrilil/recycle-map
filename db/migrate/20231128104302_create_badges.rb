class CreateBadges < ActiveRecord::Migration[7.1]
  def change
    create_table :badges do |t|
      t.integer :unlock_number
      t.string :name
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
