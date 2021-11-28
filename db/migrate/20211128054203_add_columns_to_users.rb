class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :string, limit: 140
    add_column :users, :prefecture, :integer, null: false, default: 1

    remove_column :users, :nickname, :string
  end
end
