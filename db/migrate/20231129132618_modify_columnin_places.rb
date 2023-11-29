class ModifyColumninPlaces < ActiveRecord::Migration[7.1]
  def change
    rename_column :places, :adress, :address
  end
end
