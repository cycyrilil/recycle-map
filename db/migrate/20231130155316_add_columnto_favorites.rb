class AddColumntoFavorites < ActiveRecord::Migration[7.1]
  def change
    add_column :favorites, :status, :boolean, default: false
  end
end
