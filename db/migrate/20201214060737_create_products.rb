class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end
