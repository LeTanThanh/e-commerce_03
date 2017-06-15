class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.integer :price, default: 0
      t.float :rating_point, default: 0
      t.string :picture
      t.string :description,
        default: I18n.t("admin.products.index.no_description_is_available")
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
