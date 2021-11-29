class AddColumnsToUsers2 < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :prefecture, :integer, null: false, default: 1
    add_column :users, :prefecture, :integer, default: 1
  end
end
