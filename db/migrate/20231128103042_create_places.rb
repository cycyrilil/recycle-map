class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :contact
      t.string :name
      t.string :description
      t.string :conditions
      t.string :adress

      t.timestamps
    end
  end
end
