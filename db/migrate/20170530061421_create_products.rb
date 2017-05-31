class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.integer :price
      t.float :rating_point, default: 0
      t.string :picture
      t.string :description
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
