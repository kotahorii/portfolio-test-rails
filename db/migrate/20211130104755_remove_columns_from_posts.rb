class RemoveColumnsFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :genre, :integer
  end
end
