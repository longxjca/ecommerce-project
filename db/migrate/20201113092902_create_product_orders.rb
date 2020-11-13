class CreateProductOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :product_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :purchased_quantity
      t.decimal :purchased_price
      t.decimal :purchased_pst
      t.decimal :purchased_gst
      t.decimal :purchased_hst

      t.timestamps
    end
  end
end
