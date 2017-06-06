class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :rating_point
      t.timestamps
    end
  end
end
