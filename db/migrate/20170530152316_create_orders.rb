class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.bigint :total_price
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
