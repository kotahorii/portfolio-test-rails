class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.float :rate, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
